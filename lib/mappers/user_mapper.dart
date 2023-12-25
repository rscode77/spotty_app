import 'package:spotty_app/data/models/user_model.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';
import 'package:spotty_app/mappers/vehicle_mapper.dart';

extension UserMapper on UserApiResponse {
  User mapToUser() {
    return User(
      userId: userId,
      username: username,
      email: email,
      isOnline: isOnline,
      avatarId: avatarId,
      defaultVehicle: defaultVehicle,
      userConfirmed: userConfirmed,
      isBanned: isBanned,
      banReason: banReason,
      lastActivity: lastActivity,
      vehicle: vehicle?.mapToVehicle(),
      vehicles: vehicles?.map((v) => v.mapToVehicle()).toList(),
      sentFriendRequests: sentFriendRequests?.map((u) => u.mapToUser()).toList(),
      receivedFriendRequests: receivedFriendRequests?.map((u) => u.mapToUser()).toList(),
      friends: friends?.map((u) => u.mapToUser()).toList(),
    );
  }
}