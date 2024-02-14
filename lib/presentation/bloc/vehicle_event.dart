part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();
}

class FetchBrandsEvent extends VehicleEvent {
  const FetchBrandsEvent();

  @override
  List<Object> get props => [];
}

class LoadModelsEvent extends VehicleEvent {
  final String brand;

  const LoadModelsEvent({required this.brand});

  @override
  List<Object> get props => [brand];
}

class AddNewVehicleEvent extends VehicleEvent {
  final AddVehicleRequest vehicle;

  const AddNewVehicleEvent({required this.vehicle});

  @override
  List<Object> get props => [vehicle];
}

class FetchVehiclesEvent extends VehicleEvent {
  final int userId;

  const FetchVehiclesEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
