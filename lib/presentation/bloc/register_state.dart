part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();

  @override
  List<Object> get props => [];
}

class RegisterResultState extends RegisterState {
  final String message;
  final String field;
  final bool isSuccess;

  const RegisterResultState({
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
