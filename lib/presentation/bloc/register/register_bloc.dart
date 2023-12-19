import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/common/models/api_response.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserApiRepository userApiRepository;

  RegisterBloc({required this.userApiRepository}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterUserEvent>(_onRegisterUserEvent);
  }

  Future<FutureOr<void>> _onRegisterUserEvent(RegisterUserEvent event, Emitter<RegisterState> emit) async {
    try {
      Response response = await userApiRepository.addUser(
        RegisterUserRequest(
          email: event.email,
          username: event.username,
          password: event.password,
        ),
      );

      if (response.isSuccessful()) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        emit(RegisterResultState(
          isSuccess: true,
          message: apiResponse.message,
        ));

      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        if (e.response!.isToManyRequests()) {
          await Future.delayed(const Duration(seconds: 1));
          add(RegisterUserEvent(
            username: event.username,
            password: event.password,
            email: event.email,
          ));
        }
        if (e.response!.isBadRequest()) {
          ApiResponse apiResponse = ApiResponse.fromJson(e.response!.data);
          emit(RegisterResultState(
            message: apiResponse.message,
            field: apiResponse.field,
            isSuccess: false,
          ));
        }
        if (e.response!.isUnauthorized()) {}
      } else {
        throw UnimplementedError();
      }
    }
  }
}
