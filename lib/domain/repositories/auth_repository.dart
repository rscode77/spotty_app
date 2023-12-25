import 'package:dio/dio.dart';
import 'package:spotty_app/data/repositories/auth_interface.dart';
import 'package:spotty_app/endpoints.dart';

class AuthRepository implements AuthInterface{
  final Dio dio;

  AuthRepository({required this.dio});

  @override
  Future<Response> refreshTokens(String refreshToken) async {
    final Response response = await dio.post(
      AuthEndpoints.refreshTokens,
      data: {
        'refreshToken': refreshToken,
      },
    );
    return response;
  }
}