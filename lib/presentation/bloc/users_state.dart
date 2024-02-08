part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];
}

class CreatingNewChatState extends UsersState {
  final int userId;

  const CreatingNewChatState({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class ChatExistsState extends UsersState {
  final ChatFirebase? chat;
  final UserFirebase user;

  const ChatExistsState({
    required this.chat,
    required this.user,
  });

  @override
  List<Object?> get props => [chat, user];
}
