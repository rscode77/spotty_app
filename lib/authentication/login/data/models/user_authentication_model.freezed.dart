// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_authentication_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserAuthenticationModel _$UserAuthenticationModelFromJson(
    Map<String, dynamic> json) {
  return _UserAuthenticationModel.fromJson(json);
}

/// @nodoc
mixin _$UserAuthenticationModel {
  String? get id => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAuthenticationModelCopyWith<UserAuthenticationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthenticationModelCopyWith<$Res> {
  factory $UserAuthenticationModelCopyWith(UserAuthenticationModel value,
          $Res Function(UserAuthenticationModel) then) =
      _$UserAuthenticationModelCopyWithImpl<$Res, UserAuthenticationModel>;
  @useResult
  $Res call(
      {String? id, String token, int userId, String username, String email});
}

/// @nodoc
class _$UserAuthenticationModelCopyWithImpl<$Res,
        $Val extends UserAuthenticationModel>
    implements $UserAuthenticationModelCopyWith<$Res> {
  _$UserAuthenticationModelCopyWithImpl(this._value, this._then);

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
abstract class _$$UserAuthenticationModelImplCopyWith<$Res>
    implements $UserAuthenticationModelCopyWith<$Res> {
  factory _$$UserAuthenticationModelImplCopyWith(
          _$UserAuthenticationModelImpl value,
          $Res Function(_$UserAuthenticationModelImpl) then) =
      __$$UserAuthenticationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String token, int userId, String username, String email});
}

/// @nodoc
class __$$UserAuthenticationModelImplCopyWithImpl<$Res>
    extends _$UserAuthenticationModelCopyWithImpl<$Res,
        _$UserAuthenticationModelImpl>
    implements _$$UserAuthenticationModelImplCopyWith<$Res> {
  __$$UserAuthenticationModelImplCopyWithImpl(
      _$UserAuthenticationModelImpl _value,
      $Res Function(_$UserAuthenticationModelImpl) _then)
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
    return _then(_$UserAuthenticationModelImpl(
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
class _$UserAuthenticationModelImpl implements _UserAuthenticationModel {
  const _$UserAuthenticationModelImpl(
      {this.id,
      required this.token,
      required this.userId,
      required this.username,
      required this.email});

  factory _$UserAuthenticationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAuthenticationModelImplFromJson(json);

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
    return 'UserAuthenticationModel(id: $id, token: $token, userId: $userId, username: $username, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAuthenticationModelImpl &&
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
  _$$UserAuthenticationModelImplCopyWith<_$UserAuthenticationModelImpl>
      get copyWith => __$$UserAuthenticationModelImplCopyWithImpl<
          _$UserAuthenticationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAuthenticationModelImplToJson(
      this,
    );
  }
}

abstract class _UserAuthenticationModel implements UserAuthenticationModel {
  const factory _UserAuthenticationModel(
      {final String? id,
      required final String token,
      required final int userId,
      required final String username,
      required final String email}) = _$UserAuthenticationModelImpl;

  factory _UserAuthenticationModel.fromJson(Map<String, dynamic> json) =
      _$UserAuthenticationModelImpl.fromJson;

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
  _$$UserAuthenticationModelImplCopyWith<_$UserAuthenticationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
