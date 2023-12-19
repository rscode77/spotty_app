import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';
import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/data/repositories/user_api_interface.dart';
import 'package:spotty_app/domain/entities/user_authentication.dart';
import 'package:spotty_app/common/models/api_response.dart';
import 'package:spotty_app/endpoints.dart';

class UserApiRepository implements UserApiInterface {
  final Dio dio;

  UserApiRepository({required this.dio});

  @override
  Future<Response> addUser(RegisterUserRequest request) async {
    final Response response = await dio.post(
      AuthenticationEndpoints.addUser,
      data: request.toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getUser(String email, String password) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Response> loginUser(LoginUserRequest request) async {
    final Response response = await dio.post(
      AuthenticationEndpoints.loginUser,
      data: request.toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> updateUserData(UserAuthentication user) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
