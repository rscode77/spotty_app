class UserAuth {
  final String? accessToken;
  final String? refreshToken;
  final int? userId;
  final String? username;
  final String? email;
  final String? firebaseUID;

  UserAuth({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.username,
    required this.email,
    required this.firebaseUID,
  });
}
