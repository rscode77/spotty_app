class Endpoints {
  static const String baseUrl = 'https://api.rscode.site:7777/api';
}

class AuthenticationEndpoints {
  static const String _prefix = '/User';
  static const String loginUser = '${Endpoints.baseUrl}$_prefix/LoginUser';
}