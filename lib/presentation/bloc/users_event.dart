part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class CheckChatExistsEvent extends UsersEvent {
  final UserFirebase user;

  const CheckChatExistsEvent({required this.user});

  @override
  List<Object> get props => [user];
}