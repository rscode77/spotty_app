// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAuthenticationModelImpl _$$UserAuthenticationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserAuthenticationModelImpl(
      id: json['id'] as String?,
      token: json['token'] as String,
      userId: json['userId'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$UserAuthenticationModelImplToJson(
        _$UserAuthenticationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
    };
