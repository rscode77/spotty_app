// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_data_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatDataResponse _$ChatDataResponseFromJson(Map<String, dynamic> json) {
  return _ChatDataResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatDataResponse {
  String get lastMessage => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  DateTime get messageTime => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatDataResponseCopyWith<ChatDataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDataResponseCopyWith<$Res> {
  factory $ChatDataResponseCopyWith(
          ChatDataResponse value, $Res Function(ChatDataResponse) then) =
      _$ChatDataResponseCopyWithImpl<$Res, ChatDataResponse>;
  @useResult
  $Res call(
      {String lastMessage, String toUserId, DateTime messageTime, bool isRead});
}

/// @nodoc
class _$ChatDataResponseCopyWithImpl<$Res, $Val extends ChatDataResponse>
    implements $ChatDataResponseCopyWith<$Res> {
  _$ChatDataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastMessage = null,
    Object? toUserId = null,
    Object? messageTime = null,
    Object? isRead = null,
  }) {
    return _then(_value.copyWith(
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      messageTime: null == messageTime
          ? _value.messageTime
          : messageTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatDataResponseImplCopyWith<$Res>
    implements $ChatDataResponseCopyWith<$Res> {
  factory _$$ChatDataResponseImplCopyWith(_$ChatDataResponseImpl value,
          $Res Function(_$ChatDataResponseImpl) then) =
      __$$ChatDataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String lastMessage, String toUserId, DateTime messageTime, bool isRead});
}

/// @nodoc
class __$$ChatDataResponseImplCopyWithImpl<$Res>
    extends _$ChatDataResponseCopyWithImpl<$Res, _$ChatDataResponseImpl>
    implements _$$ChatDataResponseImplCopyWith<$Res> {
  __$$ChatDataResponseImplCopyWithImpl(_$ChatDataResponseImpl _value,
      $Res Function(_$ChatDataResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastMessage = null,
    Object? toUserId = null,
    Object? messageTime = null,
    Object? isRead = null,
  }) {
    return _then(_$ChatDataResponseImpl(
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      messageTime: null == messageTime
          ? _value.messageTime
          : messageTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatDataResponseImpl implements _ChatDataResponse {
  const _$ChatDataResponseImpl(
      {required this.lastMessage,
      required this.toUserId,
      required this.messageTime,
      required this.isRead});

  factory _$ChatDataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatDataResponseImplFromJson(json);

  @override
  final String lastMessage;
  @override
  final String toUserId;
  @override
  final DateTime messageTime;
  @override
  final bool isRead;

  @override
  String toString() {
    return 'ChatDataResponse(lastMessage: $lastMessage, toUserId: $toUserId, messageTime: $messageTime, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDataResponseImpl &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.messageTime, messageTime) ||
                other.messageTime == messageTime) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, lastMessage, toUserId, messageTime, isRead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDataResponseImplCopyWith<_$ChatDataResponseImpl> get copyWith =>
      __$$ChatDataResponseImplCopyWithImpl<_$ChatDataResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatDataResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatDataResponse implements ChatDataResponse {
  const factory _ChatDataResponse(
      {required final String lastMessage,
      required final String toUserId,
      required final DateTime messageTime,
      required final bool isRead}) = _$ChatDataResponseImpl;

  factory _ChatDataResponse.fromJson(Map<String, dynamic> json) =
      _$ChatDataResponseImpl.fromJson;

  @override
  String get lastMessage;
  @override
  String get toUserId;
  @override
  DateTime get messageTime;
  @override
  bool get isRead;
  @override
  @JsonKey(ignore: true)
  _$$ChatDataResponseImplCopyWith<_$ChatDataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
