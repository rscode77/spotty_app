import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_authentication_model.freezed.dart';
part 'user_authentication_model.g.dart';

@freezed
class UserAuthenticationModel with _$UserAuthenticationModel {
  const factory UserAuthenticationModel({
    String? id,
    required String token,
    required int userId,
    required String username,
    required String email,
  }) = _UserAuthenticationModel;

  factory UserAuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthenticationModelFromJson(json);
}
