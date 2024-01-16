import 'package:firebase_database/firebase_database.dart';

class ChatMessage {
  final String text;
  final int timestamp;
  final int senderID;
  final Map<String, bool> readBy;

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.senderID,
    required this.readBy,
  });

  factory ChatMessage.fromMap(Map<dynamic, dynamic> map) {
    return ChatMessage(
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? 0,
      senderID: map['sender'] ?? 0,
      readBy: (map['readBy'] as Map<dynamic, dynamic>?)?.cast<String, bool>() ?? {},
    );
  }
}