import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatPageArguments {
  final String chatID;
  final String chatName;
  final bool isOnline;
  final List<UserFirebase> members;

  ChatPageArguments({
    required this.chatID,
    required this.chatName,
    required this.members,
    required this.isOnline,
  });
}
