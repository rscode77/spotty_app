import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/user_chat_data_model.dart';
import 'package:spotty_app/domain/entities/user_chats_response.dart';
import 'package:spotty_app/mappers/user_chats_mapper.dart';

class ChatService {
  final DatabaseReference _chatDataDatabaseReference = FirebaseDatabase.instance.ref().child('chat_data');

  Stream<List<UserChats>> getUserChats(String userId) {

  }

  Stream<DatabaseEvent> getMessages(String chatId) {
    return _chatDataDatabaseReference.child('chats/$chatId/messages').onValue;
  }

  Future<void> sendMessage({
    required String currentUserId,
    required String chatId,
    required String message,
    required String toUserId,
  }) async {
    // Send the message
    await _chatDataDatabaseReference.child('chats/$chatId/messages').push().set({
      'text': message,
      'from': currentUserId,
      'to': toUserId,
      'timestamp': ServerValue.timestamp,
      'readBy': [currentUserId],
    });

    // Update the chat data for the current user
    await _chatDataDatabaseReference.child('users/$currentUserId/chats/$chatId').set({
      'lastMessage': message,
      'timestamp': ServerValue.timestamp,
    });

    // Update the chat data for the recipient user
    await _chatDataDatabaseReference.child('users/$toUserId/chats/$chatId').set({
      'lastMessage': message,
      'timestamp': ServerValue.timestamp,
    });
  }

  Future<void> resetUnreadMessages({
    required String currentUserId,
    required String chatId,
  }) {
    return _chatDataDatabaseReference.child('users/$currentUserId/chats/$chatId/unreadMessages').set(0);
  }

  Stream<int> getUnreadMessagesCount({
    required String currentUserId,
    required String chatId,
  }) {
    return _chatDataDatabaseReference.child('users/$currentUserId/chats/$chatId/unreadMessages').onValue.map((event) {
      return (event.snapshot.value as int? ?? 0);
    });
  }
}
