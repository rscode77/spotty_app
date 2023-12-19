import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_authentication.freezed.dart';
part 'user_authentication.g.dart';

@freezed
class UserAuthentication with _$UserAuthentication{
  const factory UserAuthentication({
    String? id,
    required String token,
    required int userId,
    required String username,
    required String email,
  }) = _UserAuthentication;

  factory UserAuthentication.fromJson(Map<String, dynamic> json) =>
      _$UserAuthenticationFromJson(json);
}
