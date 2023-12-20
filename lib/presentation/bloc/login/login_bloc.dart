import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/data/models/requests/login_user_request.dart';
import 'package:spotty_app/data/models/user_auth_model.dart';
import 'package:spotty_app/domain/entities/user_authentication_api_response.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/injector.dart';
import 'package:spotty_app/manager/dio_manager.dart';
import 'package:spotty_app/mappers/user_auth_mapper.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final CommonStorage commonStorage;
  final UserRepository userApiRepository;


  LoginBloc({
    required this.commonStorage,
    required this.userApiRepository,
  }) : super(LoginInitial()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<LoginUserEvent>(_onLoginUserEvent);
  }

  FutureOr<void> _onLoginInitialEvent(LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(const LoginInputState());
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
