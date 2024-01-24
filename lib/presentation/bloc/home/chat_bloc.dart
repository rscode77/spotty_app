import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/domain/repositories/chat_repository.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final LoginBloc loginBloc;

  final StreamController<List<ChatFirebase>> _chatController = StreamController<List<ChatFirebase>>.broadcast();
  final StreamController<List<UserFirebase>> _usersController = StreamController<List<UserFirebase>>.broadcast();
  StreamController<List<ChatMessage>> _chatMessageController = StreamController<List<ChatMessage>>.broadcast();

  Stream<List<ChatFirebase>> get chatStream => _chatController.stream;

  Stream<List<ChatMessage>> get chatMessageStream => _chatMessageController.stream;

  Stream<List<UserFirebase>> get usersStream => _usersController.stream;

  int messageLimit = 40;

  ChatBloc({
    required this.chatRepository,
    required this.loginBloc,
  }) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
    on<EnterChatEvent>(_onEnterChatEvent);
    on<LoadMoreMessagesEvent>(_onLoadMoreMessagesEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  Future<void> _onChatInitialEvent(ChatInitialEvent event, Emitter<ChatState> emit) async {
    //chatRepository.sendMessage(chatID: '-Nos68u9_TYObMSb2t24', senderID: 26, message: 'test');
    
    final usersFuture = chatRepository.getAllUsersStream().first;
    final chatsFuture = chatRepository.getUserChatsStream(userID: loginBloc.loggedInUserId).first;

    final results = await Future.wait([usersFuture, chatsFuture]);

    List<UserFirebase>? users = results[0] as List<UserFirebase>?;
    List<ChatFirebase>? chats = results[1] as List<ChatFirebase>?;

    if (users != null && chats != null) {
      for (ChatFirebase chat in chats) {
        if (!chat.isGroup) {
          final int participant = chat.members.where((member) => member != loginBloc.loggedInUserId).first;

          chat.membersData.addAll(chat.members.map((member) {
            return users.firstWhere((user) => user.userId.toInt() == member);
          }));

          final UserFirebase user = chat.membersData.firstWhere((user) => user.userId.toInt() == participant);
          chat.name = user.username;
        }
      }

      _chatController.add(chats);
    }
  }

  Future<void> _onEnterChatEvent(EnterChatEvent event, Emitter<ChatState> emit) async {
    _resetChatMessageController();
    await _loadMessages(event.chatId);
  }

  Future<void> _onLoadMoreMessagesEvent(LoadMoreMessagesEvent event, Emitter<ChatState> emit) async {
    messageLimit += Constants.messageLimit;
    final chatMessagesStream = chatRepository.getChatMessagesStream(
      chatId: event.chatId,
      limit: messageLimit,
    );
    await for (final chatMessages in chatMessagesStream) {
      _chatMessageController.add(chatMessages);
    }
  }

  Future<void> _loadMessages(String chatId) async {
    messageLimit = Constants.messageLimit;
    final chatMessagesStream = chatRepository.getChatMessagesStream(
      chatId: chatId,
      limit: messageLimit,
    );
    await for (final chatMessages in chatMessagesStream) {
      _chatMessageController.add(chatMessages);
    }
  }

  void _resetChatMessageController() {
    _chatMessageController.close();
    _chatMessageController = StreamController<List<ChatMessage>>.broadcast();
  }

  @override
  Future<void> close() {
    _chatController.close();
    _chatMessageController.close();
    _usersController.close();
    return super.close();
  }

  Future<FutureOr<void>> _onSendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) async {
    ChatState entryState = state;
    try {
      chatRepository.sendMessage(
        chatID: event.chatId,
        senderID: 5,
        message: event.message,
      );
      emit(const SendMessageStatus(true));
    } catch (e) {
      emit(const SendMessageStatus(false));
    } finally {
      emit(entryState);
    }
  }
}
