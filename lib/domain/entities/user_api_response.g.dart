// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserApiResponseImpl _$$UserApiResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserApiResponseImpl(
      userId: json['userId'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      isOnline: json['isOnline'] as bool,
      avatarId: json['avatarId'] as int,
      defaultVehicle: json['defaultVehicle'] as int,
      userConfirmed: json['userConfirmed'] as bool,
      isBanned: json['isBanned'] as bool,
      banReason: json['banReason'] as String,
      lastActivity: DateTime.parse(json['lastActivity'] as String),
      vehicle: json['vehicle'] == null
          ? null
          : VehicleApiResponse.fromJson(
              json['vehicle'] as Map<String, dynamic>),
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => VehicleApiResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      userEvents: (json['userEvents'] as List<dynamic>?)
          ?.map((e) => EventApiResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      sentFriendRequests: (json['sentFriendRequests'] as List<dynamic>?)
          ?.map((e) => UserApiResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      receivedFriendRequests: (json['receivedFriendRequests'] as List<dynamic>?)
          ?.map((e) => UserApiResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => UserApiResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserApiResponseImplToJson(
        _$UserApiResponseImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'isOnline': instance.isOnline,
      'avatarId': instance.avatarId,
      'defaultVehicle': instance.defaultVehicle,
      'userConfirmed': instance.userConfirmed,
      'isBanned': instance.isBanned,
      'banReason': instance.banReason,
      'lastActivity': instance.lastActivity.toIso8601String(),
      'vehicle': instance.vehicle,
      'vehicles': instance.vehicles,
      'userEvents': instance.userEvents,
      'sentFriendRequests': instance.sentFriendRequests,
      'receivedFriendRequests': instance.receivedFriendRequests,
      'friends': instance.friends,
    };
