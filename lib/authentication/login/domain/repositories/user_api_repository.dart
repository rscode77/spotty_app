import 'package:dio/dio.dart';
import 'package:spotty_app/authentication/login/data/models/user_authentication_model.dart';
import 'package:spotty_app/authentication/login/data/repositories/user_api_interface.dart';
import 'package:spotty_app/authentication/login/data/requests/login_user_request.dart';
import 'package:spotty_app/common/models/api_response.dart';
import 'package:spotty_app/endpoints.dart';

class UserApiRepository implements UserApiInterface {
  final Dio dio;
  UserApiRepository({required this.dio});

  @override
  Future<ApiResponse> addUser(String email, String password) {
    // TODO: implement addUser
    throw UnimplementedError();
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
  Future<ApiResponse> updateUserData(UserAuthenticationModel user) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
