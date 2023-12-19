part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final String username;
  final String password;
  final String email;

  const RegisterUserEvent({
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        email,
      ];
}
