import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatPageArguments {
  final String chatId;
  final List<UserFirebase> members;
  final bool isNewChat;
  final String chatName;

  ChatPageArguments({
    this.chatId = '',
    this.members = const [],
    this.isNewChat = false,
    this.chatName = '',
  });
}
