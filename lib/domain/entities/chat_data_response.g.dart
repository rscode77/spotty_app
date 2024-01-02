// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatDataResponseImpl _$$ChatDataResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatDataResponseImpl(
      lastMessage: json['lastMessage'] as String,
      toUserId: json['toUserId'] as String,
      messageTime: DateTime.parse(json['messageTime'] as String),
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$$ChatDataResponseImplToJson(
        _$ChatDataResponseImpl instance) =>
    <String, dynamic>{
      'lastMessage': instance.lastMessage,
      'toUserId': instance.toUserId,
      'messageTime': instance.messageTime.toIso8601String(),
      'isRead': instance.isRead,
    };
