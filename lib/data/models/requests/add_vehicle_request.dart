class AddVehicleRequest {
  int userId;
  String vehicleBrand;
  String? vehicleColor;
  int vehicleHp;
  String? vehicleImage;
  String vehicleModel;
  String? vehicleDescription;
  int vehicleType;

  AddVehicleRequest({
    required this.userId,
    required this.vehicleBrand,
    this.vehicleColor = '',
    required this.vehicleHp,
    this.vehicleImage = '',
    required this.vehicleModel,
    this.vehicleDescription = '',
    required this.vehicleType,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'vehicleBrand': vehicleBrand,
      'vehicleColor': vehicleColor ?? '',
      'vehicleHp': vehicleHp,
      'vehicleImage': vehicleImage ?? '',
      'vehicleModel': vehicleModel,
      'vehicleDescription': vehicleDescription ?? '',
      'vehicleType': vehicleType,
    };
  }
}