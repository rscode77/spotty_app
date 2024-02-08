import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatPageArguments {
  final int avatar;
  final String chatID;
  final String chatName;
  final String? lastMessageId;
  final bool isOnline;
  final List<UserFirebase> members;


  ChatPageArguments({
    required this.avatar,
    required this.chatID,
    required this.chatName,
    required this.members,
    required this.isOnline,
    required this.lastMessageId,
  });
}
