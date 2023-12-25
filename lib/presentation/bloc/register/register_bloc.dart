import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/errors/api_exception_handler.dart';
import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userApiRepository;

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
      ApiExceptionHandler().handleDioException(
        dioException: e,
        onToManyRequests: () {},
        onBadRequest: (response) {},
        onUnauthorized: () {},
      );
    }
  }
}
