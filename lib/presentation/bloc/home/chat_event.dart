part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatInitialEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}

class EnterChatEvent extends ChatEvent {
  final String chatId;

  const EnterChatEvent({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String message;

  const SendMessageEvent({
    required this.chatId,
    required this.message,
  });

  @override
  List<Object> get props => [chatId, message];
}

class LoadMoreMessagesEvent extends ChatEvent {
  final String chatId;

  const LoadMoreMessagesEvent({
    required this.chatId,
  });

  @override
  List<Object> get props => [chatId];
}