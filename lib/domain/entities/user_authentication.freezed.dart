// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/entities/user_authentication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserAuthentication _$UserAuthenticationFromJson(Map<String, dynamic> json) {
  return _UserAuthentication.fromJson(json);
}

/// @nodoc
mixin _$UserAuthentication {
  String? get id => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAuthenticationCopyWith<UserAuthentication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthenticationCopyWith<$Res> {
  factory $UserAuthenticationCopyWith(
          UserAuthentication value, $Res Function(UserAuthentication) then) =
      _$UserAuthenticationCopyWithImpl<$Res, UserAuthentication>;
  @useResult
  $Res call(
      {String? id, String token, int userId, String username, String email});
}

/// @nodoc
class _$UserAuthenticationCopyWithImpl<$Res, $Val extends UserAuthentication>
    implements $UserAuthenticationCopyWith<$Res> {
  _$UserAuthenticationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? token = null,
    Object? userId = null,
    Object? username = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAuthenticationImplCopyWith<$Res>
    implements $UserAuthenticationCopyWith<$Res> {
  factory _$$UserAuthenticationImplCopyWith(_$UserAuthenticationImpl value,
          $Res Function(_$UserAuthenticationImpl) then) =
      __$$UserAuthenticationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String token, int userId, String username, String email});
}

/// @nodoc
class __$$UserAuthenticationImplCopyWithImpl<$Res>
    extends _$UserAuthenticationCopyWithImpl<$Res, _$UserAuthenticationImpl>
    implements _$$UserAuthenticationImplCopyWith<$Res> {
  __$$UserAuthenticationImplCopyWithImpl(_$UserAuthenticationImpl _value,
      $Res Function(_$UserAuthenticationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? token = null,
    Object? userId = null,
    Object? username = null,
    Object? email = null,
  }) {
    return _then(_$UserAuthenticationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAuthenticationImpl implements _UserAuthentication {
  const _$UserAuthenticationImpl(
      {this.id,
      required this.token,
      required this.userId,
      required this.username,
      required this.email});

  factory _$UserAuthenticationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAuthenticationImplFromJson(json);

  @override
  final String? id;
  @override
  final String token;
  @override
  final int userId;
  @override
  final String username;
  @override
  final String email;

  @override
  String toString() {
    return 'UserAuthentication(id: $id, token: $token, userId: $userId, username: $username, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAuthenticationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, token, userId, username, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAuthenticationImplCopyWith<_$UserAuthenticationImpl> get copyWith =>
      __$$UserAuthenticationImplCopyWithImpl<_$UserAuthenticationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAuthenticationImplToJson(
      this,
    );
  }
}

abstract class _UserAuthentication implements UserAuthentication {
  const factory _UserAuthentication(
      {final String? id,
      required final String token,
      required final int userId,
      required final String username,
      required final String email}) = _$UserAuthenticationImpl;

  factory _UserAuthentication.fromJson(Map<String, dynamic> json) =
      _$UserAuthenticationImpl.fromJson;

  @override
  String? get id;
  @override
  String get token;
  @override
  int get userId;
  @override
  String get username;
  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$UserAuthenticationImplCopyWith<_$UserAuthenticationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
