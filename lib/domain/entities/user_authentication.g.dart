// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../domain/entities/user_authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAuthenticationImpl _$$UserAuthenticationImplFromJson(
        Map<String, dynamic> json) =>
    _$UserAuthenticationImpl(
      id: json['id'] as String?,
      token: json['token'] as String,
      userId: json['userId'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$UserAuthenticationImplToJson(
        _$UserAuthenticationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
    };
