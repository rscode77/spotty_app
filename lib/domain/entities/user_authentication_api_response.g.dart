// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_authentication_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAuthenticationApiResponseImpl
    _$$UserAuthenticationApiResponseImplFromJson(Map<String, dynamic> json) =>
        _$UserAuthenticationApiResponseImpl(
          id: json['id'] as String?,
          accessToken: json['accessToken'] as String,
          refreshToken: json['refreshToken'] as String,
          userId: json['userId'] as int,
          username: json['username'] as String,
          email: json['email'] as String,
        );

Map<String, dynamic> _$$UserAuthenticationApiResponseImplToJson(
        _$UserAuthenticationApiResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
    };
