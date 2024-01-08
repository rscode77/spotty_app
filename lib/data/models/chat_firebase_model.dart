import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatFirebase {
  String chatID;
  String name;
  List<UserFirebase> members;
  Map<String, dynamic> lastMessage;
  bool isGroup;

  ChatFirebase({
    required this.chatID,
    required this.name,
    required this.members,
    required this.lastMessage,
    required this.isGroup,
  });
}
