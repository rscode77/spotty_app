class UserFirebase {
  String userId;
  String username;
  int avatarId;
  bool isOnline;

  UserFirebase({
    required this.userId,
    required this.username,
    required this.avatarId,
    required this.isOnline,
  });

  factory UserFirebase.fromMap(String userId, Map<dynamic, dynamic> map) {
    return UserFirebase(
      userId: userId,
      username: map['username'] as String? ?? '',
      avatarId: map['avatarId'] as int? ?? 0,
      isOnline: map['isOnline'] as bool? ?? false,
    );
  }
}
