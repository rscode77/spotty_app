import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotty_app/domain/entities/event_api_response.dart';
import 'package:spotty_app/domain/entities/vehicle_api_response.dart';

part 'user_api_response.freezed.dart';
part 'user_api_response.g.dart';

@freezed
class UserApiResponse with _$UserApiResponse {
  const factory UserApiResponse({
    required int userId,
    required String username,
    required String email,
    required bool isOnline,
    required int avatarId,
    required int defaultVehicle,
    required bool userConfirmed,
    required bool isBanned,
    required String banReason,
    required DateTime lastActivity,
    VehicleApiResponse? vehicle,
    List<VehicleApiResponse>? vehicles,
    List<EventApiResponse>? userEvents,
    List<UserApiResponse>? sentFriendRequests,
    List<UserApiResponse>? receivedFriendRequests,
    List<UserApiResponse>? friends,
  }) = _UserApiResponse;

  factory UserApiResponse.fromJson(Map<String, dynamic> json) => _$UserApiResponseFromJson(json);
}