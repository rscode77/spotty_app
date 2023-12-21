import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/data/models/user_model.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/auth_api_response.dart';
import 'package:spotty_app/domain/entities/user_api_response.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/endpoints.dart';
import 'package:spotty_app/injector.dart';
import 'package:spotty_app/manager/dio_manager.dart';
import 'package:spotty_app/mappers/user_mapper.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
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
  final UserDataService userDataService;
  final UserRepository userRepository;

  bool get isUserLoggedIn => loginBloc.state is LoginResultState && (loginBloc.state as LoginResultState).isSuccess;

  HomeBloc({
    required this.loginBloc,
    required this.authRepository,
    required this.commonStorage,
    required this.userDataService,
    required this.userRepository,
  }) : super(HomeInitial()) {
    Timer.periodic(const Duration(minutes: 15), (timer) {
      add(const RefreshTokenEvent());
    });
    on<HomeEvent>((event, emit) {});
    on<RefreshTokenEvent>(_onRefreshTokenEvent);
    on<GetCurrentUserData>(_onGetCurrentUserData);
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

  Future<FutureOr<void>> _onGetCurrentUserData(GetCurrentUserData event, Emitter<HomeState> emit) async {
    if (isUserLoggedIn) {
      commonStorage.getInt(CommonStorageKeys.userId).then((userId) async {
        Response response = await userRepository.getUserData(userId.orZero());

        if (response.isSuccessful()) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.data);
          UserApiResponse userResponse = UserApiResponse.fromJson(apiResponse.data as Map<String, dynamic>);
          User user = userResponse.mapToUser();

          print(user.email);
        }
      });
    }
  }
}
