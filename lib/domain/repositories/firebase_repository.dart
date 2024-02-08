import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/services/encryption_service.dart';

class FirebaseRepository {
  final DatabaseReference _chatsRef = FirebaseDatabase.instance.ref().child('chats');
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref().child('users');

  Stream<List<ChatFirebase>> getUserChatsStream({required int userID}) {
    return _chatsRef.orderByChild('lastMessage/timestamp').onValue.asyncMap((event) async {
      List<ChatFirebase> userChats = await _getUserChats(userID);
      return userChats;
    });
  }

  Stream<List<UserFirebase>> getAllUsersStream() {
    return _usersRef.onValue.map((event) {
      List<UserFirebase> allUsers = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> userData = event.snapshot.value as Map<dynamic, dynamic>;
        userData.forEach((key, value) {
          UserFirebase user = UserFirebase.fromMap(key.toString(), value);
          allUsers.add(user);
        });
      }
      return allUsers;
    });
  }

  Stream<List<ChatMessage>> getChatMessagesStream({
    required String chatId,
    required int limit,
  }) {
    DatabaseReference messagesRef = _chatsRef.child(chatId).child('messages');

    StreamController<List<ChatMessage>> chatMessagesController = StreamController<List<ChatMessage>>();
    List<ChatMessage> currentMessages = [];

    Query messagesQuery = messagesRef.orderByKey().limitToLast(limit);

    messagesQuery.onChildAdded.listen(
          (event) {
        Map<dynamic, dynamic>? value = event.snapshot.value as Map<dynamic, dynamic>?;
        if (value != null) {
          ChatMessage newMessage = ChatMessage.fromMap(value);
          currentMessages.insert(0, newMessage.copyWith(text: EncryptionService().decryptData(newMessage.text)));
          chatMessagesController.add(List.from(currentMessages));
        }
      },
    );

    return chatMessagesController.stream;
  }

  Future<void> updateLastActivity(int userId) async {
    try {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      await _usersRef.child(userId.toString()).update({'lastActivity': timestamp});
    } catch (error) {
      print("Error updating last activity: $error");
      throw error;
    }
  }

  Future<List<ChatFirebase>> _getUserChats(int userID) async {
    List<ChatFirebase> userChats = [];

    final DatabaseEvent chatsSnapshot = await _usersRef.child('$userID/chats').once();
    if (chatsSnapshot.snapshot.value is Map) {
      final Map<dynamic, dynamic> chatData = chatsSnapshot.snapshot.value as Map<dynamic, dynamic>;

      for (var entry in chatData.entries) {
        String chatID = entry.key;

        final DatabaseEvent chatSnapshot = await _chatsRef.child(chatID).once();

        if (chatSnapshot.snapshot.value is Map) {
          final Map<dynamic, dynamic> chatDetails = chatSnapshot.snapshot.value as Map<dynamic, dynamic>;

          ChatMessage? lastMessage;
          try {
            Stream<ChatMessage?> lastMessageStream = _getLastMessage(chatID);
            lastMessage = await lastMessageStream.first;
          } catch (e) {
            print('No messages found for chat $chatID');
          }

          userChats.add(
            ChatFirebase(
              chatID: chatID,
              isGroup: chatDetails['isGroup'],
              members: (chatDetails['members'] as List).map((item) => int.parse(item.toString())).toList(),
              name: chatDetails['name'],
              lastMessage: lastMessage?.text,
              lastMessageId: lastMessage?.messageId,
              lastMessageTimestamp: lastMessage?.timestamp,
              isLastMessageRead: lastMessage?.readBy.containsKey(userID.toString()) ?? false,
            ),
          );
        } else if (chatSnapshot.snapshot.value is List) {
          print("chatSnapshot.snapshot.value is a List, not a Map");
        }
      }
    } else {
      print('Brak czatów dla użytkownika o ID $userID');
    }
    return userChats;
  }

  Future<UserFirebase> getUserData(int userId) {
    return _usersRef.child(userId.toString()).once().then((snapshot) {
      return UserFirebase.fromMap(userId.toString(), snapshot.snapshot.value as Map<dynamic, dynamic>);
    });
  }

  Stream<ChatMessage?> _getLastMessage(String chatId) {
    DatabaseReference messagesRef = _chatsRef.child(chatId).child('messages');

    return messagesRef.orderByKey().limitToLast(1).onValue.map((event) {
      if (event.snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> value = event.snapshot.value as Map<dynamic, dynamic>;
        String lastKey = value.keys.elementAt(0);
        Map<dynamic, dynamic> lastMessageData = value[lastKey];

        ChatMessage lastMessage = ChatMessage.fromMap(lastMessageData);
        return lastMessage.copyWith(
          messageId: lastKey,
          text: EncryptionService().decryptData(lastMessage.text),
        );
      }

      return null;
    });
  }

  Future<void> sendMessage({
    required String chatID,
    required int senderID,
    required String message,
  }) async {
    try {
      DatabaseReference messagesRef = _chatsRef.child(chatID).child('messages');
      DatabaseReference newMessageRef = messagesRef.push();

      int timestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      Map<String, dynamic> newMessage = {
        'text': EncryptionService().encrypt(message),
        'timestamp': timestamp,
        'sender': senderID,
        'readBy': {senderID.toString() : true},
      };
      await newMessageRef.set(newMessage);
    } catch (error) {
      print("Error sending message: $error");
      throw error;
    }
  }

  Future<void> addUserToChat(String chatID, int userID) async {
    try {
      DatabaseEvent snapshot = await _chatsRef.child(chatID).child('members').once();
      List<int> members = (snapshot.snapshot.value as List).map((item) => int.parse(item.toString())).toList();
      if (!members.contains(userID)) {
        members.add(userID);
        await _chatsRef.child(chatID).child('members').set(members);
      }
      await _usersRef.child(userID.toString()).child('chats').update({chatID: true});
    } catch (error) {
      print("Error adding user to chat: $error");
      throw error;
    }
  }

  Future<String> createChat({
    required int creatorID,
    required String chatName,
    required List<int> memberIDs,
    required bool isGroup,
  }) async {
    try {
      DatabaseReference newChatRef = _chatsRef.push();
      String newChatID = newChatRef.key!;

      Map<String, dynamic> chatData = {
        'name': chatName,
        'isGroup': isGroup,
        'members': memberIDs,
      };

      await newChatRef.set(chatData);

      for (int member in memberIDs) {
        print(member);
        await addUserToChat(newChatID, member);
      }

      return newChatID;
    } catch (error) {
      print("Error creating chat: $error");
      throw error;
    }
  }

  Future<void> markMessageAsRead({
    required String chatId,
    required String messageId,
    required int userId,
  }) async {
    try {
      DatabaseReference readByRef = _chatsRef.child(chatId).child('messages').child(messageId).child('readBy');
      await readByRef.update({userId.toString(): true});
    } catch (error) {
      print("Error marking message as read: $error");
      throw error;
    }
  }

  Future<void> updateUserLocation({
    required int userId,
    required double? latitude,
    required double? longitude,
  }) async {
    try {
      await _usersRef.child(userId.toString()).update({
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (error) {
      print("Error updating user location: $error");
      throw error;
    }
  }

  Future<void> updateVehicleData({
    required int userId,
    required String? vehicle,
    required String? vehicleColor,
    required int? vehicleType,
  }) async {
    try {
      await _usersRef.child(userId.toString()).update({
        'vehicle': vehicle,
        'vehicleColor': vehicleColor,
        'vehicleType': vehicleType ?? 0,
      });
    } catch (error) {
      print("Error updating vehicle data: $error");
      throw error;
    }
  }

  Future<ChatFirebase?> getChat({
    required int loggedInUserId,
    required int otherUserId,
  }) async {
    DatabaseEvent snapshot = await _usersRef.child(loggedInUserId.toString()).child('chats').once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> userChats = snapshot.snapshot.value as Map<dynamic, dynamic>;
      for (var entry in userChats.entries) {
        String chatId = entry.key;
        DatabaseEvent chatSnapshot = await _chatsRef.child(chatId).once();
        Map<dynamic, dynamic> chatDetails = chatSnapshot.snapshot.value as Map<dynamic, dynamic>;
        List<int> members = (chatDetails['members'] as List).map((item) => int.parse(item.toString())).toList();
        bool isGroup = chatDetails['isGroup'];
        if (!isGroup && members.contains(otherUserId)) {
          Stream<ChatMessage?> lastMessageStream = _getLastMessage(chatId);
          ChatMessage? lastMessage = await lastMessageStream.first;
          return ChatFirebase(
            chatID: chatId,
            isGroup: isGroup,
            members: members,
            name: chatDetails['name'],
            lastMessage: lastMessage?.text,
            lastMessageId: lastMessage?.messageId,
            lastMessageTimestamp: lastMessage?.timestamp,
            isLastMessageRead: true,
          );
        }
      }
    }
    return null;
  }
}