import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/authentication/login/data/models/user_authentication_model.dart';
import 'package:spotty_app/authentication/login/data/requests/login_user_request.dart';
import 'package:spotty_app/authentication/login/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/common/models/api_response.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final CommonStorage commonStorage;
  final UserApiRepository userApiRepository;

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
        UserAuthenticationModel user = UserAuthenticationModel.fromJson(
          apiResponse.data as Map<String, dynamic>,
        );

        commonStorage.putInt(CommonStorageKeys.userId, user.userId);
        commonStorage.putString(CommonStorageKeys.baererToken, user.token);

        emit(const LoginResultState(isSuccess: true));
      }
    }
    on DioException catch (e) {
      if(e.response != null && e.response!.data != null) {

        if(e.response!.isBadRequest()){
          ApiResponse? apiResponse = ApiResponse.fromJson(e.response!.data);
          print(apiResponse.message);
        }
        if(e.response!.isUnauthorized()){
          ApiResponse? apiResponse = ApiResponse.fromJson(e.response!.data);
          print(apiResponse.message);
        }
        if(e.response!.isToManyRequests()){
          print("to many requests");
        }
        if(e.response!.isServerError()){
          ApiResponse? apiResponse = ApiResponse.fromJson(e.response!.data);
          print(apiResponse.message);
        }
      }
      else {
        throw UnimplementedError();
      }
    }
  }
}
