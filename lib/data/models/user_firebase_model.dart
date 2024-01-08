class UserFirebase {
  String userID;
  String username;
  String avatar;
  Map<String, bool> chats;

  UserFirebase({
    required this.userID,
    required this.username,
    required this.avatar,
    required this.chats,
  });

  factory UserFirebase.fromMap(String userID, Map<String, dynamic> map) {
    return UserFirebase(
      userID: userID,
      username: map['username'],
      avatar: map['avatar'],
      chats: Map<String, bool>.from(map['chats']),
    );
  }
}