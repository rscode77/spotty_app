class Vehicle {
  final int vehicleId;
  final int userId;
  final String vehicleBrand;
  final String vehicleColor;
  final int vehicleHp;
  final String vehicleImage;
  final String vehicleModel;
  final String vehicleDescription;
  final int vehicleType;

  Vehicle({
    required this.vehicleId,
    required this.userId,
    required this.vehicleBrand,
    required this.vehicleColor,
    required this.vehicleHp,
    required this.vehicleImage,
    required this.vehicleModel,
    required this.vehicleDescription,
    required this.vehicleType,
  });
}

enum VehicleType{
  motorcycle,
  car
}