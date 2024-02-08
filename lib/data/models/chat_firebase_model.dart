import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatFirebase {
  List<int> members;
  List<UserFirebase> membersData = [];
  String chatID;
  String? name;
  String? lastMessage;
  String? lastMessageId;
  int avatar = 0;
  int? lastMessageTimestamp;
  bool isOnline = false;
  bool isGroup;
  bool isLastMessageRead;

  ChatFirebase({
    required this.chatID,
    required this.lastMessageTimestamp,
    required this.name,
    required this.lastMessageId,
    required this.isLastMessageRead,
    required this.members,
    required this.lastMessage,
    required this.isGroup,
  });
}
