part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetUserDataEvent extends ProfileEvent {
  const GetUserDataEvent();

  @override
  List<Object> get props => [];
}

class RemoveVehicleEvent extends ProfileEvent {
  final int vehicleId;

  const RemoveVehicleEvent({required this.vehicleId});

  @override
  List<Object> get props => [vehicleId];
}

class UpdateDefaultVehicleEvent extends ProfileEvent {
  final int vehicleId;

  const UpdateDefaultVehicleEvent({required this.vehicleId});

  @override
  List<Object> get props => [vehicleId];
}

class AddVehicleEvent extends ProfileEvent {
  final AddVehicleRequest vehicleData;

  const AddVehicleEvent({required this.vehicleData});

  @override
  List<Object> get props => [vehicleData];
}