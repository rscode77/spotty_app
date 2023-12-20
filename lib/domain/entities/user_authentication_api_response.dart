import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_authentication_api_response.freezed.dart';
part 'user_authentication_api_response.g.dart';

@freezed
class UserAuthenticationApiResponse with _$UserAuthenticationApiResponse {
  const factory UserAuthenticationApiResponse({
    String? id,
    required String accessToken,
    required String refreshToken,
    required int userId,
    required String username,
    required String email,
  }) = _UserAuthenticationApiResponse;

  factory UserAuthenticationApiResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAuthenticationApiResponseFromJson(json);
}