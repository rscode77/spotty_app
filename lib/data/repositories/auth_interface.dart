import 'package:dio/dio.dart';

abstract class AuthInterface {
  Future<Response> refreshTokens(String refreshToken);
}
