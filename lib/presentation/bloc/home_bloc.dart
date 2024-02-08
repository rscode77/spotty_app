import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotty_app/data/models/user_model.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/auth_api_response.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/firebase_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/manager/dio_manager.dart';
import 'package:spotty_app/mappers/user_mapper.dart';
import 'package:spotty_app/presentation/bloc/app_block_observer.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';
import 'package:spotty_app/utils/enums/navigation_bar_items_enum.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/gps_position_util.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginBloc loginBloc;
  final AuthRepository authRepository;
  final CommonStorage commonStorage;
  final FirebaseRepository firebaseRepository;
  final UserRepository userRepository;

  GoogleMapController? mapController;

  int get _userId => loginBloc.loggedInUserId;

  bool get isUserLoggedIn => (loginBloc.state as LoginResultState).isSuccess;

  HomeBloc({
    required this.loginBloc,
    required this.authRepository,
    required this.commonStorage,
    required this.firebaseRepository,
    required this.userRepository,
  }) : super(const HomeLoading(
          isLocationCentered: false,
          isLocationEnabled: false,
          currentTab: NavigationBarItem.map,
        )) {
    Bloc.observer = AppBlocObserver(homeBloc: this);
    Timer.periodic(const Duration(minutes: 15), (timer) {
      add(const RefreshTokenEvent());
    });
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (state.isLocationEnabled ?? false) {
        await _updateLocation();
      }
    });
    on<HomeEvent>((event, emit) {});
    on<RefreshTokenEvent>(_onRefreshTokenEvent);
    on<GetCurrentUserDataEvent>(_onGetCurrentUserDataEvent);
    on<SetUserLocationStatusEvent>(_onSetUserLocationStatusEvent);
    on<CenterMapOnUserLocationEvent>(_onCenterMapOnUserLocationEvent);
    on<NavigateToLocationEvent>(_onNavigateToLocationEvent);
    on<UpdateNavigationBarItemEvent>(_onUpdateNavigationBarItemEvent);
    add(const GetCurrentUserDataEvent());
  }

  Future<FutureOr<void>> _onRefreshTokenEvent(
    RefreshTokenEvent event,
    Emitter<HomeState> emit,
  ) async {
    String? refreshToken = await commonStorage.getString(CommonStorageKeys.refreshToken);

    try {
      Response response = await authRepository.refreshTokens(refreshToken.orEmpty());
      if (response.isSuccessful()) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        AuthApiResponse tokens = AuthApiResponse.fromJson(apiResponse.data as Map<String, dynamic>);

        DioManager().updateAuthorizationHeader(tokens.accessToken);

        commonStorage.putString(CommonStorageKeys.accessToken, tokens.accessToken);
        commonStorage.putString(CommonStorageKeys.refreshToken, tokens.refreshToken);
      }
      else {
        loginBloc.add(const LogoutUserEvent());
      }
    }
    catch (e) {
      loginBloc.add(const LogoutUserEvent());
    }
  }

  Future<FutureOr<void>> _onGetCurrentUserDataEvent(
    GetCurrentUserDataEvent event,
    Emitter<HomeState> emit,
  ) async {
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

  Future<FutureOr<void>> _onSetUserLocationStatusEvent(
    SetUserLocationStatusEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _updateLocation();
    emit(state.copyWith(isLocationEnabled: !(state.isLocationEnabled ?? true)));
  }

  Future<void> _updateLocation() async {
    try {
      LatLng target = const LatLng(0, 0);
      if (state.isUserLocationEnabled) target = await GpsPositionUtil().getCurrentPosition();
      firebaseRepository.updateUserLocation(
        userId: _userId,
        latitude: state.isUserLocationEnabled ? target.latitude : null,
        longitude: state.isUserLocationEnabled ? target.longitude : null,
      );
      print('Location updated');
    } catch (e) {
      print('nie udało się wyłączyć lokalizacji');
    }
  }

  Future<void> _onCenterMapOnUserLocationEvent(
    CenterMapOnUserLocationEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isLocationCentered == false) {
      CameraPosition camera = CameraPosition(
        target: await GpsPositionUtil().getCurrentPosition(),
        zoom: 10,
      );

      if (mapController != null) {
        mapController?.moveCamera(CameraUpdate.newCameraPosition(camera));
      }
    }

    emit(state.copyWith(isLocationCentered: !(state.isLocationCentered ?? false)));
  }

  Future<FutureOr<void>> _onNavigateToLocationEvent(
    NavigateToLocationEvent event,
    Emitter<HomeState> emit,
  ) async {
    CameraPosition camera = CameraPosition(
      target: event.location,
      zoom: 10,
    );

    if (mapController != null) {
      mapController?.moveCamera(CameraUpdate.newCameraPosition(camera));
    }

    emit(
      state.copyWith(
        isLocationCentered: false,
        currentTab: NavigationBarItem.map,
      ),
    );
  }

  FutureOr<void> _onUpdateNavigationBarItemEvent(
    UpdateNavigationBarItemEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(currentTab: event.navigationBarItem));
  }

  @override
  close() {
    mapController?.dispose();
    return super.close();
  }
}
