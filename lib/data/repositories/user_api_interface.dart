import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';

abstract class UserApiInterface {
  Future<Response> addUser(RegisterUserRequest request);
  Future<Response> getUserData(int userId);
  Future<Response> loginUser(LoginUserRequest request);
  Future<ApiResponse> updateUserData(UserApiResponse user);
}