part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginInitialEvent extends LoginEvent {
  const LoginInitialEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginUserEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class LogoutUserEvent extends LoginEvent {
  const LogoutUserEvent();

  @override
  List<Object?> get props => [];
}