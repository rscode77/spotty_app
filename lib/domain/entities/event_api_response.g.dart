// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventApiResponseImpl _$$EventApiResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$EventApiResponseImpl(
      eventId: json['eventId'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      picture: json['picture'] as String,
      address: json['address'] as String,
      date: DateTime.parse(json['date'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      userId: json['userId'] as int,
      creationDate: DateTime.parse(json['creationDate'] as String),
      isPublic: json['isPublic'] as bool,
      joined: json['joined'] as bool,
      isOwner: json['isOwner'] as bool,
      membersCount: json['membersCount'] as int,
    );

Map<String, dynamic> _$$EventApiResponseImplToJson(
        _$EventApiResponseImpl instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'title': instance.title,
      'description': instance.description,
      'picture': instance.picture,
      'address': instance.address,
      'date': instance.date.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'userId': instance.userId,
      'creationDate': instance.creationDate.toIso8601String(),
      'isPublic': instance.isPublic,
      'joined': instance.joined,
      'isOwner': instance.isOwner,
      'membersCount': instance.membersCount,
    };
