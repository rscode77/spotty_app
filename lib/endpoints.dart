class Endpoints {
  static const String baseUrl = 'https://api.rscode.site:7777/api';
}

class UserEndpoints {
  static const String _prefix = '/User';
  static const String addUser = '${Endpoints.baseUrl}$_prefix/AddUser';
  static const String getUserData = '${Endpoints.baseUrl}$_prefix/GetUser';
  static const String loginUser = '${Endpoints.baseUrl}$_prefix/LoginUser';

}

class AuthEndpoints {
  static const String _prefix = '/Auth';
  static const String refreshTokens = '${Endpoints.baseUrl}$_prefix/RefreshToken';
}