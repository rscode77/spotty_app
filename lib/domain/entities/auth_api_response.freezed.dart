// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthApiResponse _$AuthApiResponseFromJson(Map<String, dynamic> json) {
  return _AuthApiResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthApiResponse {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthApiResponseCopyWith<AuthApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthApiResponseCopyWith<$Res> {
  factory $AuthApiResponseCopyWith(
          AuthApiResponse value, $Res Function(AuthApiResponse) then) =
      _$AuthApiResponseCopyWithImpl<$Res, AuthApiResponse>;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$AuthApiResponseCopyWithImpl<$Res, $Val extends AuthApiResponse>
    implements $AuthApiResponseCopyWith<$Res> {
  _$AuthApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthApiResponseImplCopyWith<$Res>
    implements $AuthApiResponseCopyWith<$Res> {
  factory _$$AuthApiResponseImplCopyWith(_$AuthApiResponseImpl value,
          $Res Function(_$AuthApiResponseImpl) then) =
      __$$AuthApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$$AuthApiResponseImplCopyWithImpl<$Res>
    extends _$AuthApiResponseCopyWithImpl<$Res, _$AuthApiResponseImpl>
    implements _$$AuthApiResponseImplCopyWith<$Res> {
  __$$AuthApiResponseImplCopyWithImpl(
      _$AuthApiResponseImpl _value, $Res Function(_$AuthApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$AuthApiResponseImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthApiResponseImpl implements _AuthApiResponse {
  const _$AuthApiResponseImpl(
      {required this.accessToken, required this.refreshToken});

  factory _$AuthApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthApiResponseImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthApiResponse(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthApiResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthApiResponseImplCopyWith<_$AuthApiResponseImpl> get copyWith =>
      __$$AuthApiResponseImplCopyWithImpl<_$AuthApiResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthApiResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthApiResponse implements AuthApiResponse {
  const factory _AuthApiResponse(
      {required final String accessToken,
      required final String refreshToken}) = _$AuthApiResponseImpl;

  factory _AuthApiResponse.fromJson(Map<String, dynamic> json) =
      _$AuthApiResponseImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthApiResponseImplCopyWith<_$AuthApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
