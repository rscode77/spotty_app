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

  ChatMessage copyWith({String? text}) {
    return ChatMessage(
      text: text ?? this.text,
      timestamp: timestamp,
      senderID: senderID,
      readBy: readBy,
    );
  }

  factory ChatMessage.fromMap(Map<dynamic, dynamic> map) {
    return ChatMessage(
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? 0,
      senderID: map['sender'] ?? 0,
      readBy: (map['readBy'] as Map<dynamic, dynamic>?)?.cast<String, bool>() ?? {},
    );
  }
}