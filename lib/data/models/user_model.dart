import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/data/models/vehicle_model.dart';

class User {
  final int userId;
  final String username;
  final String email;
  final bool isOnline;
  final int avatarId;
  final int defaultVehicle;
  final bool userConfirmed;
  final bool isBanned;
  final String banReason;
  final DateTime lastActivity;
  final Vehicle? vehicle;
  final List<Vehicle>? vehicles;
  final List<Event>? userEvents;
  final List<User>? sentFriendRequests;
  final List<User>? receivedFriendRequests;
  final List<User>? friends;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.isOnline,
    required this.avatarId,
    required this.defaultVehicle,
    required this.userConfirmed,
    required this.isBanned,
    required this.banReason,
    required this.lastActivity,
    required this.vehicle,
    required this.vehicles,
    required this.userEvents,
    required this.sentFriendRequests,
    required this.receivedFriendRequests,
    required this.friends,
  });
}
