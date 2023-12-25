import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/vehicle_model.dart';

class UserLocationService {
  final DatabaseReference _userLoactionDatabaseReference =
      FirebaseDatabase.instance.ref().child('users_locations');

  Future<void> saveUserLocation({
    required DateTime lastUpdate,
    required double  latitude,
    required double longitude,
    required String username,
    required int userId,
    required String? vehicleColor,
    required VehicleType vehicleType,
  }) async {
    await _userLoactionDatabaseReference.child(userId.toString()).set({
      'lastUpdate': lastUpdate.toLocal().toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'username': username,
      'userId': userId,
      'vehicleColor': vehicleColor,
      'vehicleType': vehicleType == VehicleType.car ? 0 : 1,
    });
  }

  Stream<DatabaseEvent> getUsersLocation() {
    return _userLoactionDatabaseReference.onValue;
  }

  Future<void> deleteUserLocationById(int userId) async {
    await _userLoactionDatabaseReference.child(userId.toString()).remove();
  }
}
