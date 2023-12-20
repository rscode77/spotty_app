import 'package:dio/dio.dart';
import 'package:spotty_app/endpoints.dart';

class DioManager {
  static final DioManager _instance = DioManager._();
  late Dio dio;

  factory DioManager() {
    return _instance;
  }

  DioManager._() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        contentType: 'application/json',
      ),
    );
  }

  void updateAuthorizationHeader(String newToken) {
    print('Updating authorization header with token: $newToken');
    dio.options.headers['Authorization'] = 'Bearer $newToken';
    print('Authorization header updated successfully');
  }
}
