class LoginUserRequest {
  final String username;
  final String password;

  LoginUserRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}