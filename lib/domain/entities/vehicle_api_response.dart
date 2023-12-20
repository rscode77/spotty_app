import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_api_response.freezed.dart';
part 'vehicle_api_response.g.dart';

@freezed
class VehicleApiResponse with _$VehicleApiResponse {
  const factory VehicleApiResponse({
    required int vehicleId,
    required int userId,
    required String vehicleBrand,
    required String vehicleColor,
    required int vehicleHp,
    required String vehicleImage,
    required String vehicleModel,
    required String vehicleDescription,
    required int vehicleType,
  }) = _VehicleApiResponse;

  factory VehicleApiResponse.fromJson(Map<String, dynamic> json) => _$VehicleApiResponseFromJson(json);
}