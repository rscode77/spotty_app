part of 'vehicle_bloc.dart';

class VehicleState extends Equatable {
  final List<String> vehicleBrands;
  final List<String> vehicleModels;
  final bool isBrandsLoading;
  final bool isModelsLoading;
  final bool isLoading;
  final bool isSuccess;
  final String? message;

  const VehicleState({
    required this.vehicleBrands,
    required this.vehicleModels,
    this.isBrandsLoading = false,
    this.isModelsLoading = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.message,
  });

  @override
  List<Object?> get props => [
        vehicleBrands,
        vehicleModels,
        isBrandsLoading,
        isModelsLoading,
        isLoading,
        isSuccess,
        message,
      ];

  VehicleState copyWith({
    List<String>? vehicleBrands,
    List<String>? vehicleModels,
    bool? isBrandLoading,
    bool? isModelLoading,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return VehicleState(
      vehicleBrands: vehicleBrands ?? this.vehicleBrands,
      vehicleModels: vehicleModels ?? this.vehicleModels,
      isLoading: isLoading ?? this.isLoading,
      isBrandsLoading: isBrandsLoading,
      isModelsLoading: isModelsLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }
}
