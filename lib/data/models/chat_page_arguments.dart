import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatPageArguments {
  final String chatId;
  final List<UserFirebase> members;
  final bool isNewChat;

  ChatPageArguments({
    required this.chatId,
    required this.members,
    required this.isNewChat,
  });
}
