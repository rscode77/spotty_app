import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  final StreamController<List<ChatFirebase>> _chatController =
  StreamController<List<ChatFirebase>>.broadcast();
  StreamController<List<ChatMessage>> _chatMessageController =
  StreamController<List<ChatMessage>>.broadcast();
  final StreamController<List<UserFirebase>> _usersController =
  StreamController<List<UserFirebase>>.broadcast();

  Stream<List<ChatFirebase>> get chatStream => _chatController.stream;

  Stream<List<ChatMessage>> get chatMessageStream =>
      _chatMessageController.stream;

  Stream<List<UserFirebase>> get usersStream => _usersController.stream;

  String lastMessageKey = '';

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
    on<EnterChatEvent>(_onEnterChatEvent);
    on<LoadMoreMessagesEvent>(_onLoadMoreMessagesEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  Future<FutureOr<void>> _onChatInitialEvent(
      ChatInitialEvent event, Emitter<ChatState> emit) async {
    chatRepository.getUserChatsStream(userID: 5).listen((event) {
      _chatController.add(event);
    });

    chatRepository.getAllUsersStream().listen((event) {
      _usersController.add(event);
    });
  }

  Future<void> _onEnterChatEvent(
      EnterChatEvent event, Emitter<ChatState> emit) async {
    _resetChatMessageController();
    await _loadMessages(event.chatId);
  }

  Future<void> _onLoadMoreMessagesEvent(
      LoadMoreMessagesEvent event, Emitter<ChatState> emit) async {
    final chatMessagesStream = chatRepository.getChatMessagesStream(
        chatId: event.chatId, startAtKey: event.startAtKey);
    await for (final chatMessages in chatMessagesStream) {
      _chatMessageController.add(chatMessages);
      if (chatMessages.isNotEmpty) {
        lastMessageKey = chatMessages.last.text;
      }
    }
  }

  Future<void> _loadMessages(String chatId) async {
    final chatMessagesStream = chatRepository.getChatMessagesStream(
        chatId: chatId, startAtKey: lastMessageKey);
    await for (final chatMessages in chatMessagesStream) {
      _chatMessageController.add(chatMessages);
      if (chatMessages.isNotEmpty) {
        lastMessageKey = chatMessages.last.text;
      }
    }
  }

  void _resetChatMessageController() {
    _chatMessageController.close();
    _chatMessageController = StreamController<List<ChatMessage>>.broadcast();
    lastMessageKey = '';
  }

  @override
  Future<void> close() {
    _chatController.close();
    _chatMessageController.close();
    _usersController.close();
    return super.close();
  }

  Future<FutureOr<void>> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    ChatState entryState = state;
    try {
      chatRepository.sendMessage(event.chatId, 5, event.message);
      emit(const SendMessageStatus(true));
    } catch (e) {
      emit(const SendMessageStatus(false));
    } finally {
      emit(entryState);
    }
  }
}
