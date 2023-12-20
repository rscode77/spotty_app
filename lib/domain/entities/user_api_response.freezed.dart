// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserApiResponse _$UserApiResponseFromJson(Map<String, dynamic> json) {
  return _UserApiResponse.fromJson(json);
}

/// @nodoc
mixin _$UserApiResponse {
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  int get avatarId => throw _privateConstructorUsedError;
  int get defaultVehicle => throw _privateConstructorUsedError;
  bool get userConfirmed => throw _privateConstructorUsedError;
  bool get isBanned => throw _privateConstructorUsedError;
  String get banReason => throw _privateConstructorUsedError;
  DateTime get lastActivity => throw _privateConstructorUsedError;
  VehicleApiResponse? get vehicle => throw _privateConstructorUsedError;
  List<VehicleApiResponse>? get vehicles => throw _privateConstructorUsedError;
  List<EventApiResponse>? get userEvents => throw _privateConstructorUsedError;
  List<UserApiResponse>? get sentFriendRequests =>
      throw _privateConstructorUsedError;
  List<UserApiResponse>? get receivedFriendRequests =>
      throw _privateConstructorUsedError;
  List<UserApiResponse>? get friends => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserApiResponseCopyWith<UserApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserApiResponseCopyWith<$Res> {
  factory $UserApiResponseCopyWith(
          UserApiResponse value, $Res Function(UserApiResponse) then) =
      _$UserApiResponseCopyWithImpl<$Res, UserApiResponse>;
  @useResult
  $Res call(
      {int userId,
      String username,
      String email,
      bool isOnline,
      int avatarId,
      int defaultVehicle,
      bool userConfirmed,
      bool isBanned,
      String banReason,
      DateTime lastActivity,
      VehicleApiResponse? vehicle,
      List<VehicleApiResponse>? vehicles,
      List<EventApiResponse>? userEvents,
      List<UserApiResponse>? sentFriendRequests,
      List<UserApiResponse>? receivedFriendRequests,
      List<UserApiResponse>? friends});

  $VehicleApiResponseCopyWith<$Res>? get vehicle;
}

/// @nodoc
class _$UserApiResponseCopyWithImpl<$Res, $Val extends UserApiResponse>
    implements $UserApiResponseCopyWith<$Res> {
  _$UserApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? isOnline = null,
    Object? avatarId = null,
    Object? defaultVehicle = null,
    Object? userConfirmed = null,
    Object? isBanned = null,
    Object? banReason = null,
    Object? lastActivity = null,
    Object? vehicle = freezed,
    Object? vehicles = freezed,
    Object? userEvents = freezed,
    Object? sentFriendRequests = freezed,
    Object? receivedFriendRequests = freezed,
    Object? friends = freezed,
  }) {
    return _then(_value.copyWith(
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
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      avatarId: null == avatarId
          ? _value.avatarId
          : avatarId // ignore: cast_nullable_to_non_nullable
              as int,
      defaultVehicle: null == defaultVehicle
          ? _value.defaultVehicle
          : defaultVehicle // ignore: cast_nullable_to_non_nullable
              as int,
      userConfirmed: null == userConfirmed
          ? _value.userConfirmed
          : userConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      isBanned: null == isBanned
          ? _value.isBanned
          : isBanned // ignore: cast_nullable_to_non_nullable
              as bool,
      banReason: null == banReason
          ? _value.banReason
          : banReason // ignore: cast_nullable_to_non_nullable
              as String,
      lastActivity: null == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime,
      vehicle: freezed == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as VehicleApiResponse?,
      vehicles: freezed == vehicles
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<VehicleApiResponse>?,
      userEvents: freezed == userEvents
          ? _value.userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<EventApiResponse>?,
      sentFriendRequests: freezed == sentFriendRequests
          ? _value.sentFriendRequests
          : sentFriendRequests // ignore: cast_nullable_to_non_nullable
              as List<UserApiResponse>?,
      receivedFriendRequests: freezed == receivedFriendRequests
          ? _value.receivedFriendRequests
          : receivedFriendRequests // ignore: cast_nullable_to_non_nullable
              as List<UserApiResponse>?,
      friends: freezed == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<UserApiResponse>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VehicleApiResponseCopyWith<$Res>? get vehicle {
    if (_value.vehicle == null) {
      return null;
    }

    return $VehicleApiResponseCopyWith<$Res>(_value.vehicle!, (value) {
      return _then(_value.copyWith(vehicle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserApiResponseImplCopyWith<$Res>
    implements $UserApiResponseCopyWith<$Res> {
  factory _$$UserApiResponseImplCopyWith(_$UserApiResponseImpl value,
          $Res Function(_$UserApiResponseImpl) then) =
      __$$UserApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userId,
      String username,
      String email,
      bool isOnline,
      int avatarId,
      int defaultVehicle,
      bool userConfirmed,
      bool isBanned,
      String banReason,
      DateTime lastActivity,
      VehicleApiResponse? vehicle,
      List<VehicleApiResponse>? vehicles,
      List<EventApiResponse>? userEvents,
      List<UserApiResponse>? sentFriendRequests,
      List<UserApiResponse>? receivedFriendRequests,
      List<UserApiResponse>? friends});

  @override
  $VehicleApiResponseCopyWith<$Res>? get vehicle;
}

/// @nodoc
class __$$UserApiResponseImplCopyWithImpl<$Res>
    extends _$UserApiResponseCopyWithImpl<$Res, _$UserApiResponseImpl>
    implements _$$UserApiResponseImplCopyWith<$Res> {
  __$$UserApiResponseImplCopyWithImpl(
      _$UserApiResponseImpl _value, $Res Function(_$UserApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? isOnline = null,
    Object? avatarId = null,
    Object? defaultVehicle = null,
    Object? userConfirmed = null,
    Object? isBanned = null,
    Object? banReason = null,
    Object? lastActivity = null,
    Object? vehicle = freezed,
    Object? vehicles = freezed,
    Object? userEvents = freezed,
    Object? sentFriendRequests = freezed,
    Object? receivedFriendRequests = freezed,
    Object? friends = freezed,
  }) {
    return _then(_$UserApiResponseImpl(
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
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      avatarId: null == avatarId
          ? _value.avatarId
          : avatarId // ignore: cast_nullable_to_non_nullable
              as int,
      defaultVehicle: null == defaultVehicle
          ? _value.defaultVehicle
          : defaultVehicle // ignore: cast_nullable_to_non_nullable
              as int,
      userConfirmed: null == userConfirmed
          ? _value.userConfirmed
          : userConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      isBanned: null == isBanned
          ? _value.isBanned
          : isBanned // ignore: cast_nullable_to_non_nullable
              as bool,
      banReason: null == banReason
          ? _value.banReason
          : banReason // ignore: cast_nullable_to_non_nullable
              as String,
      lastActivity: null == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime,
      vehicle: freezed == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as VehicleApiResponse?,
      vehicles: freezed == vehicles
          ? _value._vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<VehicleApiResponse>?,
      userEvents: freezed == userEvents
          ? _value._userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<EventApiResponse>?,
      sentFriendRequests: freezed == sentFriendRequests
          ? _value._sentFriendRequests
          : sentFriendRequests // ignore: cast_nullable_to_non_nullable
              as List<UserApiResponse>?,
      receivedFriendRequests: freezed == receivedFriendRequests
          ? _value._receivedFriendRequests
          : receivedFriendRequests // ignore: cast_nullable_to_non_nullable
              as List<UserApiResponse>?,
      friends: freezed == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<UserApiResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserApiResponseImpl implements _UserApiResponse {
  const _$UserApiResponseImpl(
      {required this.userId,
      required this.username,
      required this.email,
      required this.isOnline,
      required this.avatarId,
      required this.defaultVehicle,
      required this.userConfirmed,
      required this.isBanned,
      required this.banReason,
      required this.lastActivity,
      this.vehicle,
      final List<VehicleApiResponse>? vehicles,
      final List<EventApiResponse>? userEvents,
      final List<UserApiResponse>? sentFriendRequests,
      final List<UserApiResponse>? receivedFriendRequests,
      final List<UserApiResponse>? friends})
      : _vehicles = vehicles,
        _userEvents = userEvents,
        _sentFriendRequests = sentFriendRequests,
        _receivedFriendRequests = receivedFriendRequests,
        _friends = friends;

  factory _$UserApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserApiResponseImplFromJson(json);

  @override
  final int userId;
  @override
  final String username;
  @override
  final String email;
  @override
  final bool isOnline;
  @override
  final int avatarId;
  @override
  final int defaultVehicle;
  @override
  final bool userConfirmed;
  @override
  final bool isBanned;
  @override
  final String banReason;
  @override
  final DateTime lastActivity;
  @override
  final VehicleApiResponse? vehicle;
  final List<VehicleApiResponse>? _vehicles;
  @override
  List<VehicleApiResponse>? get vehicles {
    final value = _vehicles;
    if (value == null) return null;
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EventApiResponse>? _userEvents;
  @override
  List<EventApiResponse>? get userEvents {
    final value = _userEvents;
    if (value == null) return null;
    if (_userEvents is EqualUnmodifiableListView) return _userEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserApiResponse>? _sentFriendRequests;
  @override
  List<UserApiResponse>? get sentFriendRequests {
    final value = _sentFriendRequests;
    if (value == null) return null;
    if (_sentFriendRequests is EqualUnmodifiableListView)
      return _sentFriendRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserApiResponse>? _receivedFriendRequests;
  @override
  List<UserApiResponse>? get receivedFriendRequests {
    final value = _receivedFriendRequests;
    if (value == null) return null;
    if (_receivedFriendRequests is EqualUnmodifiableListView)
      return _receivedFriendRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserApiResponse>? _friends;
  @override
  List<UserApiResponse>? get friends {
    final value = _friends;
    if (value == null) return null;
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserApiResponse(userId: $userId, username: $username, email: $email, isOnline: $isOnline, avatarId: $avatarId, defaultVehicle: $defaultVehicle, userConfirmed: $userConfirmed, isBanned: $isBanned, banReason: $banReason, lastActivity: $lastActivity, vehicle: $vehicle, vehicles: $vehicles, userEvents: $userEvents, sentFriendRequests: $sentFriendRequests, receivedFriendRequests: $receivedFriendRequests, friends: $friends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserApiResponseImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.avatarId, avatarId) ||
                other.avatarId == avatarId) &&
            (identical(other.defaultVehicle, defaultVehicle) ||
                other.defaultVehicle == defaultVehicle) &&
            (identical(other.userConfirmed, userConfirmed) ||
                other.userConfirmed == userConfirmed) &&
            (identical(other.isBanned, isBanned) ||
                other.isBanned == isBanned) &&
            (identical(other.banReason, banReason) ||
                other.banReason == banReason) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles) &&
            const DeepCollectionEquality()
                .equals(other._userEvents, _userEvents) &&
            const DeepCollectionEquality()
                .equals(other._sentFriendRequests, _sentFriendRequests) &&
            const DeepCollectionEquality().equals(
                other._receivedFriendRequests, _receivedFriendRequests) &&
            const DeepCollectionEquality().equals(other._friends, _friends));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      username,
      email,
      isOnline,
      avatarId,
      defaultVehicle,
      userConfirmed,
      isBanned,
      banReason,
      lastActivity,
      vehicle,
      const DeepCollectionEquality().hash(_vehicles),
      const DeepCollectionEquality().hash(_userEvents),
      const DeepCollectionEquality().hash(_sentFriendRequests),
      const DeepCollectionEquality().hash(_receivedFriendRequests),
      const DeepCollectionEquality().hash(_friends));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserApiResponseImplCopyWith<_$UserApiResponseImpl> get copyWith =>
      __$$UserApiResponseImplCopyWithImpl<_$UserApiResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserApiResponseImplToJson(
      this,
    );
  }
}

abstract class _UserApiResponse implements UserApiResponse {
  const factory _UserApiResponse(
      {required final int userId,
      required final String username,
      required final String email,
      required final bool isOnline,
      required final int avatarId,
      required final int defaultVehicle,
      required final bool userConfirmed,
      required final bool isBanned,
      required final String banReason,
      required final DateTime lastActivity,
      final VehicleApiResponse? vehicle,
      final List<VehicleApiResponse>? vehicles,
      final List<EventApiResponse>? userEvents,
      final List<UserApiResponse>? sentFriendRequests,
      final List<UserApiResponse>? receivedFriendRequests,
      final List<UserApiResponse>? friends}) = _$UserApiResponseImpl;

  factory _UserApiResponse.fromJson(Map<String, dynamic> json) =
      _$UserApiResponseImpl.fromJson;

  @override
  int get userId;
  @override
  String get username;
  @override
  String get email;
  @override
  bool get isOnline;
  @override
  int get avatarId;
  @override
  int get defaultVehicle;
  @override
  bool get userConfirmed;
  @override
  bool get isBanned;
  @override
  String get banReason;
  @override
  DateTime get lastActivity;
  @override
  VehicleApiResponse? get vehicle;
  @override
  List<VehicleApiResponse>? get vehicles;
  @override
  List<EventApiResponse>? get userEvents;
  @override
  List<UserApiResponse>? get sentFriendRequests;
  @override
  List<UserApiResponse>? get receivedFriendRequests;
  @override
  List<UserApiResponse>? get friends;
  @override
  @JsonKey(ignore: true)
  _$$UserApiResponseImplCopyWith<_$UserApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
