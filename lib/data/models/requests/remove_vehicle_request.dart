class RemoveVehicleRequest{
  int userId;
  int vehicleId;

  RemoveVehicleRequest({
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