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

  final StreamController<List<ChatFirebase>> _chatController = StreamController<List<ChatFirebase>>.broadcast();
  StreamController<List<ChatMessage>> _chatMessageController = StreamController<List<ChatMessage>>.broadcast();
  final StreamController<List<UserFirebase>> _usersController = StreamController<List<UserFirebase>>.broadcast();

  Stream<List<ChatFirebase>> get chatStream => _chatController.stream;

  Stream<List<ChatMessage>> get chatMessageStream => _chatMessageController.stream;

  Stream<List<UserFirebase>> get usersStream => _usersController.stream;

  final int _messageLimit = 20;

  int messageLimit = 40;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
    on<EnterChatEvent>(_onEnterChatEvent);
    on<LoadMoreMessagesEvent>(_onLoadMoreMessagesEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  Future<FutureOr<void>> _onChatInitialEvent(ChatInitialEvent event, Emitter<ChatState> emit) async {
    //chatRepository.createChat(creatorID: 5, chatName: 'asd', memberIDs: [26,26], isGroup: false);
    // chatRepository.sendMessage(
    //   chatID: '-Nos68u9_TYObMSb2t24',
    //   senderID: 26,
    //   text: 'test',
    // );

    final usersFuture = chatRepository.getAllUsersStream().first;
    final chatsFuture = chatRepository.getUserChatsStream(userID: 26).first;

    final results = await Future.wait([usersFuture, chatsFuture]);

    final List<UserFirebase> users = results[0] as List<UserFirebase>;
    final List<ChatFirebase> chats = results[1] as List<ChatFirebase>;
    
    for (var chat in chats) {
      print(chat.members);
      if (!chat.isGroup) {
        for (var member in chat.members) {
          print('user${member}');
        }
        final user = users.firstWhere((user) => user.userId == '26');
        chat.name = user.username;
      }
    }

    _chatController.add(chats);
  }

  Future<void> _onEnterChatEvent(EnterChatEvent event, Emitter<ChatState> emit) async {
    _resetChatMessageController();
    await _loadMessages(event.chatId);
  }

  Future<void> _onLoadMoreMessagesEvent(LoadMoreMessagesEvent event, Emitter<ChatState> emit) async {
    messageLimit += 20;
    final chatMessagesStream = chatRepository.getChatMessagesStream(
      chatId: event.chatId,
      limit: messageLimit,
    );
    await for (final chatMessages in chatMessagesStream) {
      _chatMessageController.add(chatMessages);
    }
  }

  Future<void> _loadMessages(String chatId) async {
    messageLimit = _messageLimit;
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

  Future<FutureOr<void>> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    ChatState entryState = state;
    try {
      chatRepository.sendMessage(
        chatID: event.chatId,
        senderID: 5,
        text: event.message,
      );
      emit(const SendMessageStatus(true));
    } catch (e) {
      emit(const SendMessageStatus(false));
    } finally {
      emit(entryState);
    }
  }
}
