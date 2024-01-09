import 'package:spotty_app/data/models/user_firebase_model.dart';

class ChatFirebase {
  String chatID;
  String name;
  List<UserFirebase> members;
  String lastMessage;
  bool isGroup;

  ChatFirebase({
    required this.chatID,
    required this.name,
    required this.members,
    required this.lastMessage,
    required this.isGroup,
  });

  factory ChatFirebase.fromMap(String chatID, Map<dynamic, dynamic> map) {
    return ChatFirebase(
      chatID: chatID,
      name: map['name'],
      members: map['members'],
      lastMessage: map['lastMessage'],
      isGroup: map['isGroup'],
    );
  }
}
