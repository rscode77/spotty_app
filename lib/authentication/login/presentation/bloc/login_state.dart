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
  final bool isSuccess;
  final String errorMessage;

  const LoginResultState({
    required this.isSuccess,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [isSuccess, errorMessage];
}
