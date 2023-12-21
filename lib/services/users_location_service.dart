import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/vehicle_model.dart';

class UserDataService {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('users_locations');

  Future<void> saveUserData({
    required String userId,
    required DateTime lastUpdate,
    required String username,
    required String? vehicleColor,
    required VehicleType? vehicleType,
  }) async {
    await _databaseReference.child(userId).set({
      'lastUpdate': lastUpdate.toUtc().toIso8601String(),
      'username': username,
      'vehicleColor': vehicleColor,
      'vehicleType': vehicleType == VehicleType.car ? 0 : 1,
    });
  }

  Stream<DatabaseEvent> getUserDataStream() {
    return _databaseReference.onValue;
  }
}
