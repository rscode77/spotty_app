import 'package:dio/dio.dart';

extension RepsonseExtension on Response {
  bool isSuccessful() => statusCode == 200;
  bool isUnauthorized() => statusCode == 401;
  bool isToManyRequests() => statusCode == 429;
  bool isBadRequest() => statusCode! >= 400 && statusCode! < 500 && statusCode != 429;
  bool isServerError() => statusCode! >= 500 && statusCode! < 600;
}