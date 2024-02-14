import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/requests/add_vehicle_request.dart';
import 'package:spotty_app/domain/repositories/vehicle_repository.dart';
import 'package:spotty_app/presentation/bloc/profile_bloc.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'vehicle_event.dart';

part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final ProfileBloc profileBloc;
  final VehicleRepository vehicleRepository;

  VehicleBloc({
    required this.vehicleRepository,
    required this.profileBloc,
  }) : super(const VehicleState(vehicleBrands: [], vehicleModels: [])) {
    on<FetchBrandsEvent>(_onLoadBrands);
    on<LoadModelsEvent>(_onLoadModels);
    on<AddNewVehicleEvent>(_onAddVehicle);
    on<FetchVehiclesEvent>(_onFetchVehicles);
  }

  Future<void> _onLoadBrands(FetchBrandsEvent event, Emitter<VehicleState> emit) async {
    emit(state.copyWith(isBrandLoading: true));

    Response response = await vehicleRepository.getVehicleBrands();

    if (response.isSuccessful()) {
      Map<String, dynamic> data = response.data;
      List<dynamic> brands = data['Makes'];
      List<String> brandList = [];

      for (var brand in brands) {
        brandList.add(brand['make_display']);
      }

      emit(state.copyWith(
        isBrandLoading: false,
        vehicleBrands: brandList,
      ));
    }
  }

  Future<void> _onLoadModels(LoadModelsEvent event, Emitter<VehicleState> emit) async {
    emit(state.copyWith(isBrandLoading: true));

    Response response = await vehicleRepository.getVehicleModels(event.brand);

    if (response.isSuccessful()) {
      Map<String, dynamic> data = response.data;
      List<dynamic> models = data['Models'];
      List<String> modelList = [];

      for (var model in models) {
        modelList.add(model['model_name']);
      }

      emit(state.copyWith(
        isBrandLoading: false,
        vehicleModels: modelList,
      ));
    }
  }

  Future<FutureOr<void>> _onAddVehicle(AddNewVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(state.copyWith(isLoading: true));

    Response response = await vehicleRepository.addVehicle(event.vehicle);

    if (response.isSuccessful()) {
      profileBloc.add(const GetUserDataEvent());
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        message: response.data['message'],
      ));
    }
  }

  FutureOr<void> _onFetchVehicles(FetchVehiclesEvent event, Emitter<VehicleState> emit) {
    emit(state.copyWith(isLoading: true));
  }
}
