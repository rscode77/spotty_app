import 'package:spotty_app/data/models/vehicle_model.dart';

class UserLocation {
  String username;
  double latitude;
  double longitude;
  String? vehicleColor;
  VehicleType? vehicleType;

  UserLocation({
    required this.username,
    required this.latitude,
    required this.longitude,
    required this.vehicleColor,
    required this.vehicleType,
  });
}