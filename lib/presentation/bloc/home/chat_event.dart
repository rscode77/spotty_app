part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatInitialEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}
