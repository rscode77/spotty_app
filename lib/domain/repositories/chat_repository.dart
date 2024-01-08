import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatRepository {
  final DatabaseReference _chatsRef = FirebaseDatabase.instance.ref().child('chats');
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref().child('users');

  Stream<List<ChatFirebase>> getUserChatsStream({required String userID}) {
    return _chatsRef.orderByChild('lastMessage/timestamp').onValue.asyncMap((event) async {
      List<ChatFirebase> userChats = await _getUserChats(userID);
      return userChats;
    });
  }

  Future<List<ChatFirebase>> _getUserChats(String userID) async {
    DatabaseEvent snapshot = await _usersRef.child(userID).child('chats').once();
    List<String> chatIDs = [];
    if (snapshot.snapshot.value != null) {
      (snapshot.snapshot.value as Map).forEach((key, value) {
        if (value == true) {
          chatIDs.add(key);
        }
      });
    }

    print("Chat IDs: $chatIDs");

    List<ChatFirebase> userChats = [];
    for (String chatID in chatIDs) {
      DatabaseEvent chatSnapshot = await _chatsRef.child(chatID).once();
      if (chatSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> chatData = chatSnapshot.snapshot.value as Map<dynamic, dynamic>;
        List<UserFirebase> members = [];
        for (String memberID in (chatData['members'] as Map).keys) {
          DatabaseEvent userSnapshot = await _usersRef.child(memberID).once();
          if (userSnapshot.snapshot.value != null) {
            members.add(UserFirebase.fromMap(memberID, userSnapshot.snapshot.value as Map<String, dynamic>));
          }
        }
        ChatFirebase chat = ChatFirebase(
          chatID: chatID,
          name: chatData['name'],
          members: members,
          lastMessage: chatData['lastMessage'] is Map ? chatData['lastMessage'] : {},
          isGroup: chatData['isGroup'],
        );
        userChats.add(chat);
      }
    }

    userChats.sort((a, b) => b.lastMessage['timestamp'].compareTo(a.lastMessage['timestamp']));
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

      for (String memberID in memberIDs) {
        await _usersRef.child(memberID).child('chats').update({newChatID: true});
      }

      return newChatID;
    } catch (error) {
      print("Error creating chat: $error");
      throw error;
    }
  }
}
