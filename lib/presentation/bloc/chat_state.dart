part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class SendMessageStatus extends ChatState {
  final SendingStatus status;

  const SendMessageStatus(this.status);

  @override
  List<Object> get props => [status];
}

class EnteredChatState extends ChatState {
  @override
  List<Object> get props => [];
}