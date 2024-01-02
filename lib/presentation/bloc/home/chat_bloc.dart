import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/user_chat_data_model.dart';
import 'package:spotty_app/services/chat_serivce.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;
  final _chatController = StreamController<List<UserChats>>();

  Stream<List<UserChats>> get chatStream => _chatController.stream;

  ChatBloc({required this.chatService}) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
  }

  FutureOr<void> _onChatInitialEvent(ChatInitialEvent event, Emitter<ChatState> emit) {
    chatService.sendMessage(
      currentUserId: '5',
      chatId: '5',
      message: 'Hello',
      toUserId: '6',
    );

    chatService.getUserChats('5').listen((chats) {
      _chatController.add(chats);
    });
  }

  dispose() {
    _chatController.close();
  }
}
