// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserChatsResponseImpl _$$UserChatsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserChatsResponseImpl(
      chatId: json['chatId'] as String,
      lastMessage: json['lastMessage'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$UserChatsResponseImplToJson(
        _$UserChatsResponseImpl instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'lastMessage': instance.lastMessage,
      'timestamp': instance.timestamp.toIso8601String(),
    };
