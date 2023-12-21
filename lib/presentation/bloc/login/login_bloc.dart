import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';
import 'package:spotty_app/data/models/user_auth_model.dart';
import 'package:spotty_app/domain/entities/auth_api_response.dart';
import 'package:spotty_app/domain/entities/user_authentication_api_response.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
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


  LoginBloc({
    required this.authRepository,
    required this.commonStorage,
    required this.userApiRepository,
  }) : super(LoginInitial()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<LoginUserEvent>(_onLoginUserEvent);
  }

  Future<FutureOr<void>> _onLoginInitialEvent(LoginInitialEvent event, Emitter<LoginState> emit) async {
    String? refreshToken = await commonStorage.getString(CommonStorageKeys.refreshToken);
    Response response = await authRepository.refreshTokens(refreshToken.orEmpty());

    if (response.isSuccessful()) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      AuthApiResponse tokens = AuthApiResponse.fromJson(apiResponse.data as Map<String, dynamic>);

      DioManager().updateAuthorizationHeader(tokens.accessToken);

      commonStorage.putString(CommonStorageKeys.accessToken, tokens.accessToken);
      commonStorage.putString(CommonStorageKeys.refreshToken, tokens.refreshToken);

    }
    else{
      emit(const LoginInputState());
    }
  }

  Future<FutureOr<void>> _onLoginUserEvent(LoginUserEvent event, Emitter<LoginState> emit) async {
    try {
      Response response = await userApiRepository.loginUser(LoginUserRequest(
        username: event.username,
        password: event.password,
      ));

      if(response.isSuccessful()) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        UserAuthenticationApiResponse userAuth = UserAuthenticationApiResponse.fromJson(
          apiResponse.data as Map<String, dynamic>,
        );

        DioManager().updateAuthorizationHeader(userAuth.accessToken);

        commonStorage.putInt(CommonStorageKeys.userId, userAuth.userId);
        commonStorage.putString(CommonStorageKeys.accessToken, userAuth.accessToken);
        commonStorage.putString(CommonStorageKeys.refreshToken, userAuth.refreshToken);

        UserAuth loggedInUser = userAuth.mapToUser();

        emit(LoginResultState(
          isSuccess: true,
          user: loggedInUser,
        ));
      }
    }
    on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        if (e.response!.isToManyRequests()) {
          await Future.delayed(const Duration(seconds: 1));
          add(LoginUserEvent(
            username: event.username,
            password: event.password,
          ));
        }
        if (e.response!.isBadRequest()) {
          ApiResponse apiResponse = ApiResponse.fromJson(e.response!.data);
          emit(LoginResultState(
            message: apiResponse.message,
            field: apiResponse.field,
            isSuccess: false,
          ));
        }
        if (e.response!.isUnauthorized()) {
        }
      } else {
        throw UnimplementedError();
      }
    }
  }
}
