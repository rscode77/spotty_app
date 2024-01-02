// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_chats_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserChatsResponse _$UserChatsResponseFromJson(Map<String, dynamic> json) {
  return _UserChatsResponse.fromJson(json);
}

/// @nodoc
mixin _$UserChatsResponse {
  String get chatId => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserChatsResponseCopyWith<UserChatsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChatsResponseCopyWith<$Res> {
  factory $UserChatsResponseCopyWith(
          UserChatsResponse value, $Res Function(UserChatsResponse) then) =
      _$UserChatsResponseCopyWithImpl<$Res, UserChatsResponse>;
  @useResult
  $Res call({String chatId, String lastMessage, DateTime timestamp});
}

/// @nodoc
class _$UserChatsResponseCopyWithImpl<$Res, $Val extends UserChatsResponse>
    implements $UserChatsResponseCopyWith<$Res> {
  _$UserChatsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? lastMessage = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserChatsResponseImplCopyWith<$Res>
    implements $UserChatsResponseCopyWith<$Res> {
  factory _$$UserChatsResponseImplCopyWith(_$UserChatsResponseImpl value,
          $Res Function(_$UserChatsResponseImpl) then) =
      __$$UserChatsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chatId, String lastMessage, DateTime timestamp});
}

/// @nodoc
class __$$UserChatsResponseImplCopyWithImpl<$Res>
    extends _$UserChatsResponseCopyWithImpl<$Res, _$UserChatsResponseImpl>
    implements _$$UserChatsResponseImplCopyWith<$Res> {
  __$$UserChatsResponseImplCopyWithImpl(_$UserChatsResponseImpl _value,
      $Res Function(_$UserChatsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? lastMessage = null,
    Object? timestamp = null,
  }) {
    return _then(_$UserChatsResponseImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatsResponseImpl implements _UserChatsResponse {
  const _$UserChatsResponseImpl(
      {required this.chatId,
      required this.lastMessage,
      required this.timestamp});

  factory _$UserChatsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserChatsResponseImplFromJson(json);

  @override
  final String chatId;
  @override
  final String lastMessage;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'UserChatsResponse(chatId: $chatId, lastMessage: $lastMessage, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChatsResponseImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, lastMessage, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChatsResponseImplCopyWith<_$UserChatsResponseImpl> get copyWith =>
      __$$UserChatsResponseImplCopyWithImpl<_$UserChatsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChatsResponseImplToJson(
      this,
    );
  }
}

abstract class _UserChatsResponse implements UserChatsResponse {
  const factory _UserChatsResponse(
      {required final String chatId,
      required final String lastMessage,
      required final DateTime timestamp}) = _$UserChatsResponseImpl;

  factory _UserChatsResponse.fromJson(Map<String, dynamic> json) =
      _$UserChatsResponseImpl.fromJson;

  @override
  String get chatId;
  @override
  String get lastMessage;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$UserChatsResponseImplCopyWith<_$UserChatsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
