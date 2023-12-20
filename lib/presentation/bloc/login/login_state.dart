part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginInputState extends LoginState {
  const LoginInputState();

  @override
  List<Object> get props => [];
}

class LoginResultState extends LoginState {
  final UserAuth? user;
  final String message;
  final String field;
  final bool isSuccess;

  const LoginResultState({
    this.user,
    this.message = '',
    this.field = '',
    required this.isSuccess,
  });

  @override
  List<Object> get props => [
        message,
        field,
        isSuccess,
      ];
}
