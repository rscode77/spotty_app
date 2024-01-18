import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatRepository {
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
    String startAtKey = '',
    int limit = 40,
    String endAtKey = '',
  }) {
    DatabaseReference messagesRef = _chatsRef.child(chatId).child('messages');

    StreamController<List<ChatMessage>> chatMessagesController = StreamController<List<ChatMessage>>();
    List<ChatMessage> currentMessages = [];

    Query messagesQuery;

    if (startAtKey.isNotEmpty) {
      messagesQuery = messagesRef.orderByKey().startAt(startAtKey);
    } else if (endAtKey.isNotEmpty) {
      messagesQuery = messagesRef.orderByKey().endAt(endAtKey);
    } else {
      messagesQuery = messagesRef;
    }

    messagesQuery.limitToLast(limit).onChildAdded.listen((event) {
      Map<dynamic, dynamic>? value = event.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        ChatMessage newMessage = ChatMessage.fromMap(value);
        currentMessages.insert(0, newMessage);
        chatMessagesController.add(List.from(currentMessages));
      }
    });

    return chatMessagesController.stream;
  }


  Future<List<ChatFirebase>> _getUserChats(int userID) async {
    List<ChatFirebase> userChats = [];
    // Pobierz czaty danego użytkownika
    final DatabaseEvent chatsSnapshot = await _usersRef.child('$userID/chats').once();
    if (chatsSnapshot.snapshot.value is Map) {
      final Map<dynamic, dynamic> chatData = chatsSnapshot.snapshot.value as Map<dynamic, dynamic>;
      // Iteruj przez czaty
      for (var entry in chatData.entries) {
        String chatID = entry.key;
        // Pobierz dane dla każdego czatu
        final DatabaseEvent chatSnapshot = await _chatsRef.child(chatID).once();

        if (chatSnapshot.snapshot.value is Map) {
          final Map<dynamic, dynamic> chatDetails = chatSnapshot.snapshot.value as Map<dynamic, dynamic>;

          // Pobierz ostatnią wiadomość
          String lastMessage = '';
          if (chatDetails['lastMessage'] is String) {
            lastMessage = chatDetails['lastMessage'];
          }

          userChats.add(
            ChatFirebase(
              chatID: chatID,
              isGroup: chatDetails['isGroup'],
              members: [],
              name: chatDetails['name'],
              lastMessage: lastMessage,
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

  Future<void> sendMessage(String chatID, int senderID, String text) async {
    try {
      DatabaseReference messagesRef = _chatsRef.child(chatID).child('messages');
      DatabaseReference newMessageRef = messagesRef.push();

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      Map<String, dynamic> newMessage = {
        'text': text,
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
      await _chatsRef.child(chatID).child('members').update({userID.toString(): true});
      await _usersRef.child(userID.toString()).child('chats').update({chatID: true});
    } catch (error) {
      print("Error adding user to chat: $error");
      throw error;
    }
  }

  Future<String> createChat({
    required int creatorID,
    required String chatName,
    required List<String> memberIDs,
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

      addUserToChat(newChatID, creatorID);

      return newChatID;
    } catch (error) {
      print("Error creating chat: $error");
      throw error;
    }
  }
}
