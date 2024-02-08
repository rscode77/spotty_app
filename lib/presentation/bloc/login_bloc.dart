import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';
import 'package:spotty_app/data/models/user_auth_model.dart';
import 'package:spotty_app/domain/entities/auth_api_response.dart';
import 'package:spotty_app/domain/entities/user_authentication_api_response.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/manager/dio_manager.dart';
import 'package:spotty_app/mappers/user_auth_mapper.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final CommonStorage commonStorage;
  final UserRepository userApiRepository;

  late final int loggedInUserId;

  LoginBloc({
    required this.authRepository,
    required this.commonStorage,
    required this.userApiRepository,
  }) : super(const LoginInitial()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<LoginUserEvent>(_onLoginUserEvent);
    on<LogoutUserEvent>(_onLogoutUserEvent);
    add(const LoginInitialEvent());
  }

  Future<void> _onLoginInitialEvent(LoginInitialEvent event, Emitter<LoginState> emit) async {
    emit(const LoginInputState());
    String? refreshToken = await commonStorage.getString(CommonStorageKeys.refreshToken);

    if (refreshToken == null) return;

    Response response = await authRepository.refreshTokens(refreshToken.orEmpty());

    if (response.isSuccessful()) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      AuthApiResponse tokens = AuthApiResponse.fromJson(apiResponse.data as Map<String, dynamic>);

      DioManager().updateAuthorizationHeader(tokens.accessToken);

      commonStorage.putString(CommonStorageKeys.accessToken, tokens.accessToken);
      commonStorage.putString(CommonStorageKeys.refreshToken, tokens.refreshToken);

      loggedInUserId = await commonStorage.getInt(CommonStorageKeys.userId) ?? 0;

      emit(const LoginResultState(
        isSuccess: true,
      ));
    } else {
      emit(const LoginInputState());
    }
  }

  Future<FutureOr<void>> _onLoginUserEvent(LoginUserEvent event, Emitter<LoginState> emit) async {
    Response response = await userApiRepository.loginUser(LoginUserRequest(
      username: event.username,
      password: event.password,
    ));

    if (response.isSuccessful()) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      UserAuthenticationApiResponse userAuth = UserAuthenticationApiResponse.fromJson(
        apiResponse.data as Map<String, dynamic>,
      );

      DioManager().updateAuthorizationHeader(userAuth.accessToken);

      commonStorage.putInt(CommonStorageKeys.userId, userAuth.userId);
      commonStorage.putString(CommonStorageKeys.accessToken, userAuth.accessToken);
      commonStorage.putString(CommonStorageKeys.refreshToken, userAuth.refreshToken);

      loggedInUserId = userAuth.userId;

      UserAuth loggedInUser = userAuth.mapToUser();

      emit(LoginResultState(
        isSuccess: true,
        user: loggedInUser,
      ));
    }
  }

  FutureOr<void> _onLogoutUserEvent(LogoutUserEvent event, Emitter<LoginState> emit) {
    commonStorage.removeKey(CommonStorageKeys.userId);
    commonStorage.removeKey(CommonStorageKeys.accessToken);
    commonStorage.removeKey(CommonStorageKeys.refreshToken);
    emit(const LoginInputState());
  }
}