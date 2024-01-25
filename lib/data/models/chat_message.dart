class ChatMessage {
  final String text;
  final int timestamp;
  final int senderID;
  final Map<String, bool> readBy;
  String messageId = '';

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.senderID,
    required this.messageId,
    required this.readBy,
  });

  ChatMessage copyWith({
    String? text,
    String? messageId,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      messageId: messageId ?? this.messageId,
      timestamp: timestamp,
      senderID: senderID,
      readBy: readBy,
    );
  }

  factory ChatMessage.fromMap(Map<dynamic, dynamic> map) {
    return ChatMessage(
      text: map['text'] ?? '',
      messageId: map['messageId'] ?? '',
      timestamp: map['timestamp'] ?? 0,
      senderID: map['sender'] ?? 0,
      readBy: (map['readBy'] as Map<dynamic, dynamic>?)?.cast<String, bool>() ?? {},
    );
  }
}