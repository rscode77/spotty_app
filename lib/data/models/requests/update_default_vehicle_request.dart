class UpdateDefaultVehicleRequest {
  int userId;
  int vehicleId;

  UpdateDefaultVehicleRequest({
    required this.userId,
    required this.vehicleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'vehicleId': vehicleId,
    };
  }
}