class RegisterUserRequest {
  final String email;
  final String password;
  final String username;

  RegisterUserRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }
}