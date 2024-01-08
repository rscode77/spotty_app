import 'package:spotty_app/data/models/user_auth_model.dart';
import 'package:spotty_app/domain/entities/user_authentication_api_response.dart';

extension UserAuthMapper on UserAuthenticationApiResponse {
  UserAuth mapToUser() {
    return UserAuth(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      username: username,
      email: email,
      firebaseUID: firebaseUID,
    );
  }
}
