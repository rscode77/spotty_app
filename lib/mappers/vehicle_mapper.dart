import 'package:spotty_app/data/models/vehicle_model.dart';
import 'package:spotty_app/domain/entities/vehicle_api_response.dart';

extension VehicleMapper on VehicleApiResponse {
  Vehicle mapToVehicle() {
    return Vehicle(
      vehicleId: vehicleId,
      userId: userId ?? 0,
      vehicleBrand: vehicleBrand,
      vehicleColor: vehicleColor,
      vehicleHp: vehicleHp,
      vehicleImage: vehicleImage,
      vehicleModel: vehicleModel,
      vehicleDescription: vehicleDescription ?? '',
      vehicleType: vehicleType,
    );
  }
}
