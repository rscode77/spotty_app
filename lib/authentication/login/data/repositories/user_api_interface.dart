import 'package:dio/dio.dart';
import 'package:spotty_app/authentication/login/data/models/user_authentication_model.dart';
import 'package:spotty_app/authentication/login/data/requests/login_user_request.dart';
import 'package:spotty_app/common/models/api_response.dart';

abstract class UserApiInterface {
  Future<ApiResponse> addUser(String email, String password);
  Future<ApiResponse> getUser(String email, String password);
  Future<Response> loginUser(LoginUserRequest request);
  Future<ApiResponse> updateUserData(UserAuthenticationModel user);
}