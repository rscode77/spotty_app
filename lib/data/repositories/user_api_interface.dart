import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/domain/entities/user_authentication.dart';
import 'package:spotty_app/common/models/api_response.dart';

abstract class UserApiInterface {
  Future<Response> addUser(RegisterUserRequest request);
  Future<ApiResponse> getUser(String email, String password);
  Future<Response> loginUser(LoginUserRequest request);
  Future<ApiResponse> updateUserData(UserAuthentication user);
}