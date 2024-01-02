class ChatData {
  String lastMessage;
  String toUserId;
  DateTime messageTime;
  bool isRead;

  ChatData({
    required this.lastMessage,
    required this.toUserId,
    required this.messageTime,
    required this.isRead,
  });
}
