import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_api_response.freezed.dart';
part 'auth_api_response.g.dart';

@freezed
class AuthApiResponse with _$AuthApiResponse {
  const factory AuthApiResponse({
    required String accessToken,
    required String refreshToken,
  }) = _AuthApiResponse;

  factory AuthApiResponse.fromJson(Map<String, dynamic> json) => _$AuthApiResponseFromJson(json);
}