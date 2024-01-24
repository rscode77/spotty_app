import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotty_app/data/models/user_model.dart';
import 'package:spotty_app/data/models/vehicle_model.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/auth_api_response.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/manager/dio_manager.dart';
import 'package:spotty_app/mappers/user_mapper.dart';
import 'package:spotty_app/presentation/bloc/app_block_observer.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/presentation/pages/home/widgets/bottom_navigation_bar_widget.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';
import 'package:spotty_app/services/users_location_service.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginBloc loginBloc;
  final AuthRepository authRepository;
  final CommonStorage commonStorage;
  final MapController mapController;
  final UserLocationService userLocationService;
  final UserRepository userRepository;

  User get user => state.user ?? User.emptyUser();

  int get userId => user.userId.orZero();

  bool get isUserLoggedIn => (loginBloc.state as LoginResultState).isSuccess;

  HomeBloc({
    required this.loginBloc,
    required this.authRepository,
    required this.commonStorage,
    required this.mapController,
    required this.userLocationService,
    required this.userRepository,
  }) : super(HomeLoading(
          isLocationEnabled: false,
          mapController: mapController,
        )) {
    Bloc.observer = AppBlocObserver(homeBloc: this);
    Timer.periodic(const Duration(minutes: 15), (timer) {
      add(const RefreshTokenEvent());
    });
    on<HomeEvent>((event, emit) {});
    on<RefreshTokenEvent>(_onRefreshTokenEvent);
    on<GetCurrentUserDataEvent>(_onGetCurrentUserDataEvent);
    on<SetUserLocationStatusEvent>(_onSetUserLocationStatusEvent);
    on<CenterMapOnUserLocationEvent>(_onCenterMapOnUserLocationEvent);
  }

  Future<FutureOr<void>> _onRefreshTokenEvent(RefreshTokenEvent event, Emitter<HomeState> emit) async {
    String? refreshToken = await commonStorage.getString(CommonStorageKeys.refreshToken);
    Response response = await authRepository.refreshTokens(refreshToken.orEmpty());

    if (response.isSuccessful()) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      AuthApiResponse tokens = AuthApiResponse.fromJson(apiResponse.data as Map<String, dynamic>);

      DioManager().updateAuthorizationHeader(tokens.accessToken);

      commonStorage.putString(CommonStorageKeys.accessToken, tokens.accessToken);
      commonStorage.putString(CommonStorageKeys.refreshToken, tokens.refreshToken);
    }
  }

  Future<FutureOr<void>> _onGetCurrentUserDataEvent(GetCurrentUserDataEvent event, Emitter<HomeState> emit) async {
    if (isUserLoggedIn) {
      int? userId = await commonStorage.getInt(CommonStorageKeys.userId);
      Response response = await userRepository.getUserData(userId.orZero());

      if (response.isSuccessful()) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        UserApiResponse userResponse = UserApiResponse.fromJson(apiResponse.data as Map<String, dynamic>);
        User user = userResponse.mapToUser();

        emit(HomeLoaded(user: user));
      }
    }
  }

  FutureOr<void> _onSetUserLocationStatusEvent(SetUserLocationStatusEvent event, Emitter<HomeState> emit) {
    try {
      if (state.isUserLocationEnabled == false) {
        userLocationService.saveUserLocation(
          lastUpdate: DateTime.now(),
          latitude: 20,
          longitude: 20,
          username: user.username,
          userId: user.userId,
          vehicleColor: user.vehicle?.vehicleColor.orEmpty(),
          vehicleType: user.vehicle?.vehicleType == 0 ? VehicleType.car : VehicleType.motorcycle,
        );
      } else {
        userLocationService.deleteUserLocationById(user.userId);
      }
    } catch (e) {
      print('nie udało się wyłączyć lokalizacji');
    }
    emit(state.copyWith(isLocationEnabled: !(state.isLocationEnabled ?? true)));
  }

  Future<void> _onCenterMapOnUserLocationEvent(CenterMapOnUserLocationEvent event, Emitter<HomeState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double targetLat = position.latitude;
    double targetLng = position.longitude;

    state.mapController.move(LatLng(targetLat, targetLng), 13.0);

    emit(state.copyWith(mapController: state.mapController));
  }
}
