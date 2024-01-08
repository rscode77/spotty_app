// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_authentication_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserAuthenticationApiResponse _$UserAuthenticationApiResponseFromJson(
    Map<String, dynamic> json) {
  return _UserAuthenticationApiResponse.fromJson(json);
}

/// @nodoc
mixin _$UserAuthenticationApiResponse {
  String? get id => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firebaseUID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAuthenticationApiResponseCopyWith<UserAuthenticationApiResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthenticationApiResponseCopyWith<$Res> {
  factory $UserAuthenticationApiResponseCopyWith(
          UserAuthenticationApiResponse value,
          $Res Function(UserAuthenticationApiResponse) then) =
      _$UserAuthenticationApiResponseCopyWithImpl<$Res,
          UserAuthenticationApiResponse>;
  @useResult
  $Res call(
      {String? id,
      String accessToken,
      String refreshToken,
      int userId,
      String username,
      String email,
      String firebaseUID});
}

/// @nodoc
class _$UserAuthenticationApiResponseCopyWithImpl<$Res,
        $Val extends UserAuthenticationApiResponse>
    implements $UserAuthenticationApiResponseCopyWith<$Res> {
  _$UserAuthenticationApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? firebaseUID = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseUID: null == firebaseUID
          ? _value.firebaseUID
          : firebaseUID // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAuthenticationApiResponseImplCopyWith<$Res>
    implements $UserAuthenticationApiResponseCopyWith<$Res> {
  factory _$$UserAuthenticationApiResponseImplCopyWith(
          _$UserAuthenticationApiResponseImpl value,
          $Res Function(_$UserAuthenticationApiResponseImpl) then) =
      __$$UserAuthenticationApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String accessToken,
      String refreshToken,
      int userId,
      String username,
      String email,
      String firebaseUID});
}

/// @nodoc
class __$$UserAuthenticationApiResponseImplCopyWithImpl<$Res>
    extends _$UserAuthenticationApiResponseCopyWithImpl<$Res,
        _$UserAuthenticationApiResponseImpl>
    implements _$$UserAuthenticationApiResponseImplCopyWith<$Res> {
  __$$UserAuthenticationApiResponseImplCopyWithImpl(
      _$UserAuthenticationApiResponseImpl _value,
      $Res Function(_$UserAuthenticationApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? firebaseUID = null,
  }) {
    return _then(_$UserAuthenticationApiResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseUID: null == firebaseUID
          ? _value.firebaseUID
          : firebaseUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAuthenticationApiResponseImpl
    implements _UserAuthenticationApiResponse {
  const _$UserAuthenticationApiResponseImpl(
      {this.id,
      required this.accessToken,
      required this.refreshToken,
      required this.userId,
      required this.username,
      required this.email,
      required this.firebaseUID});

  factory _$UserAuthenticationApiResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UserAuthenticationApiResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final int userId;
  @override
  final String username;
  @override
  final String email;
  @override
  final String firebaseUID;

  @override
  String toString() {
    return 'UserAuthenticationApiResponse(id: $id, accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, username: $username, email: $email, firebaseUID: $firebaseUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAuthenticationApiResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firebaseUID, firebaseUID) ||
                other.firebaseUID == firebaseUID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, accessToken, refreshToken,
      userId, username, email, firebaseUID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAuthenticationApiResponseImplCopyWith<
          _$UserAuthenticationApiResponseImpl>
      get copyWith => __$$UserAuthenticationApiResponseImplCopyWithImpl<
          _$UserAuthenticationApiResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAuthenticationApiResponseImplToJson(
      this,
    );
  }
}

abstract class _UserAuthenticationApiResponse
    implements UserAuthenticationApiResponse {
  const factory _UserAuthenticationApiResponse(
      {final String? id,
      required final String accessToken,
      required final String refreshToken,
      required final int userId,
      required final String username,
      required final String email,
      required final String firebaseUID}) = _$UserAuthenticationApiResponseImpl;

  factory _UserAuthenticationApiResponse.fromJson(Map<String, dynamic> json) =
      _$UserAuthenticationApiResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  int get userId;
  @override
  String get username;
  @override
  String get email;
  @override
  String get firebaseUID;
  @override
  @JsonKey(ignore: true)
  _$$UserAuthenticationApiResponseImplCopyWith<
          _$UserAuthenticationApiResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
