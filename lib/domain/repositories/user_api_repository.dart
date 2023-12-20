import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';
import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/data/repositories/user_api_interface.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';
import 'package:spotty_app/endpoints.dart';

class UserRepository implements UserApiInterface {
  final Dio dio;

  UserRepository({required this.dio});

  @override
  Future<Response> addUser(RegisterUserRequest request) async {
    final Response response = await dio.post(
      UserEndpoints.addUser,
      data: request.toJson(),
    );
    return response;
  }

  @override
  Future<Response> getUserData(int userId) async {
    final Response response = await dio.post(
      UserEndpoints.getUserData,
      data: {
        'userId': userId,
      },
    );
    return response;
  }

  @override
  Future<Response> loginUser(LoginUserRequest request) async {
    final Response response = await dio.post(
      UserEndpoints.loginUser,
      data: request.toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> updateUserData(UserApiResponse user) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
