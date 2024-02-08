part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginInputState extends LoginState {
  const LoginInputState();
}

class LoginResultState extends LoginState {
  final String message;
  final String field;
  final bool isSuccess;

  const LoginResultState({
    UserAuth? user,
    this.message = '',
    this.field = '',
    required this.isSuccess,
  }) ;

  @override
  List<Object?> get props => [
        message,
        field,
        isSuccess,
      ];
}