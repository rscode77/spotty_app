import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/requests/add_vehicle_request.dart';
import 'package:spotty_app/data/models/requests/remove_vehicle_request.dart';
import 'package:spotty_app/data/models/requests/update_default_vehicle_request.dart';
import 'package:spotty_app/data/models/user_model.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/domain/repositories/vehicle_repository.dart';
import 'package:spotty_app/mappers/user_mapper.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LoginBloc loginBloc;
  final UserRepository userApiRepository;
  final VehicleRepository vehicleApiRepository;

  ProfileBloc({
    required this.loginBloc,
    required this.userApiRepository,
    required this.vehicleApiRepository,
  }) : super(ProfileInitial()) {
    on<AddVehicleEvent>(_onAddVehicle);
    on<GetUserDataEvent>(_onGetUserData);
    on<RemoveVehicleEvent>(_onRemoveVehicle);
    on<UpdateDefaultVehicleEvent>(_onUpdateDefaultVehicle);
    add(const GetUserDataEvent());
  }

  Future<FutureOr<void>> _onGetUserData(GetUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingState());

    Response response = await userApiRepository.getUserData(loginBloc.loggedInUserId);

    if (response.isSuccessful()) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      User user = UserApiResponse.fromJson(apiResponse.data as Map<String, dynamic>).mapToUser();
      emit(ProfileLoadedState(user: user));
    } else {
      emit(const ProfileLoadedErrorState(message: 'Error loading user data!'));
    }
  }

  FutureOr<void> _onAddVehicle(AddVehicleEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingState());

    Response response = await vehicleApiRepository.addVehicle(event.vehicleData);

    if (response.isSuccessful()) {
      add(const GetUserDataEvent());
    } else {
      emit(const ProfileLoadedErrorState(message: 'Error loading user data!'));
    }
  }

  FutureOr<void> _onRemoveVehicle(RemoveVehicleEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingState());

    Response response = await vehicleApiRepository.deleteVehicle(
      RemoveVehicleRequest(
        vehicleId: event.vehicleId,
        userId: loginBloc.loggedInUserId,
      ),
    );

    if (response.isSuccessful()) {
      add(const GetUserDataEvent());
    } else {
      emit(const ProfileLoadedErrorState(message: 'Error loading user data!'));
    }
  }

  FutureOr<void> _onUpdateDefaultVehicle(UpdateDefaultVehicleEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingState());

    Response response = await vehicleApiRepository.updateDefaultVehicle(
      UpdateDefaultVehicleRequest(
        vehicleId: event.vehicleId,
        userId: loginBloc.loggedInUserId,
      ),
    );

    if (response.isSuccessful()) {
      add(const GetUserDataEvent());
    } else {
      emit(const ProfileLoadedErrorState(message: 'Error loading user data!'));
    }
  }
}
