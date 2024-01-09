class UserFirebase {
  String userID;

  UserFirebase({
    required this.userID,
  });

  factory UserFirebase.fromMap(String userID, Map<String, dynamic> map) {
    return UserFirebase(
      userID: userID,
    );
  }
}