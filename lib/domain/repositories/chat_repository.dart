import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/services/encryption_service.dart';

class ChatRepository {
  final DatabaseReference _chatsRef = FirebaseDatabase.instance.ref().child('chats');
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref().child('users');

  Stream<List<ChatFirebase>> getUserChatsStream({required int userID}) {
    return _chatsRef
        .orderByChild('lastMessage/timestamp')
        .onValue
        .asyncMap((event) async {
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

          Stream<ChatMessage> lastMessageStream = _getLastMessage(chatID);
          ChatMessage lastMessage = await lastMessageStream.first;

          userChats.add(
            ChatFirebase(
              chatID: chatID,
              isGroup: chatDetails['isGroup'],
              members: (chatDetails['members'] as List).map((item) => int.parse(item.toString())).toList(),
              name: chatDetails['name'],
              lastMessage: lastMessage.text,
              lastMessageId: lastMessage.messageId,
              lastMessageTimestamp: lastMessage.timestamp,
              isLastMessageRead: lastMessage.readBy.containsKey(userID.toString()),
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

  Stream<ChatMessage> _getLastMessage(String chatId) {
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

      throw Exception('No messages found for chat $chatId');
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
        'readBy': {senderID: true},
      };
      await newMessageRef.set(newMessage);
    } catch (error) {
      print("Error sending message: $error");
      throw error;
    }
  }

  Future<void> addUserToChat(String chatID, int userID) async {
    try {
      await _chatsRef.child(chatID).child('members').set(userID);
      await _usersRef.child(userID.toString()).child('chats').set({chatID: true});
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
}