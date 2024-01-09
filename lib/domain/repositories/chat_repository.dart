import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
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

  Future<List<ChatFirebase>> _getUserChats(int userID) async {
    List<ChatFirebase> userChats = [];
    // Pobierz czaty danego użytkownika
    final DatabaseEvent chatsSnapshot = await _usersRef.child('$userID/chats').once();
    if (chatsSnapshot.snapshot.value is Map) {
      final Map<dynamic, dynamic> chatData = chatsSnapshot.snapshot.value as Map<dynamic, dynamic>;
      print(chatData);
      if (chatData != null) {
        // Iteruj przez czaty
        print(chatData.length);
        for (var entry in chatData.entries) {
          String chatID = entry.key;
          // Pobierz dane dla każdego czatu
          final DatabaseEvent chatSnapshot = await _chatsRef.child('$chatID').once();

          if (chatSnapshot.snapshot.value is Map) {
            final Map<dynamic, dynamic> chatDetails = chatSnapshot.snapshot.value as Map<dynamic, dynamic>;

            // Pobierz dane członków czatu
            List<UserFirebase> members = [];
            if (chatDetails['members'] is List) {
              for (String memberID in chatDetails['members']) {
                final DatabaseEvent userSnapshot = await _usersRef.child('$memberID').once();
                if (userSnapshot.snapshot.value is Map) {
                  Map<String, dynamic> userData = Map<String, dynamic>.from(userSnapshot.snapshot.value as Map);
                  members.add(UserFirebase.fromMap(memberID, userData));
                }
              }
            }

            // Pobierz ostatnią wiadomość
            String lastMessage = '';
            if (chatDetails['lastMessage'] is String) {
              lastMessage = chatDetails['lastMessage'];
            }

            userChats.add(
              ChatFirebase(
                chatID: chatID,
                isGroup: chatDetails['isGroup'],
                members: members,
                name: chatDetails['name'],
                lastMessage: lastMessage,
              ),
            );

            print('Chat ID: $chatID');
            print('Dane czatu: $chatDetails');
            print('Czy grupa: ${chatDetails['isGroup']}');
            print('Członkowie: ${chatDetails['members']}');
            print('Nazwa: ${chatDetails['name']}');
          } else if (chatSnapshot.snapshot.value is List) {
            // handle the list case
            print("chatSnapshot.snapshot.value is a List, not a Map");
          }
        }
      } else {
        print('Brak czatów dla użytkownika o ID $userID');
      }
    } else if (chatsSnapshot.snapshot.value is List) {
      // handle the list case
      print("chatsSnapshot.snapshot.value is a List, not a Map");
    }
    print(userChats.length);
    return userChats;
  }

  // Future<void> sendMessage(String chatID, int senderID, String text) async {
  //   try {
  //     DatabaseReference messagesRef = _chatsRef.child(chatID).child('messages');
  //     DatabaseReference newMessageRef = messagesRef.push();
  //
  //     int timestamp = DateTime.now().millisecondsSinceEpoch;
  //     Map<String, dynamic> newMessage = {
  //       'text': text,
  //       'timestamp': timestamp,
  //       'sender': senderID,
  //       'readBy': {senderID: true},
  //     };
  //
  //     await newMessageRef.set(newMessage);
  //   } catch (error) {
  //     print("Error sending message: $error");
  //     throw error;
  //   }
  // }

  // Future<void> addUserToChat(String chatID, int userID) async {
  //   try {
  //     await _chatsRef.child(chatID).child('members').update({userID.toString(): true});
  //     await _usersRef.child(userID.toString()).child('chats').update({chatID: true});
  //   } catch (error) {
  //     print("Error adding user to chat: $error");
  //     throw error;
  //   }
  // }

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

      return newChatID;
    } catch (error) {
      print("Error creating chat: $error");
      throw error;
    }
  }
}
