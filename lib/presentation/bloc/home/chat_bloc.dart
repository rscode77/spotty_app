import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/domain/repositories/chat_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  final StreamController<List<ChatFirebase>> _chatController = StreamController<List<ChatFirebase>>.broadcast();
  StreamController<List<ChatMessage>> _chatMessageController = StreamController<List<ChatMessage>>();
  final StreamController<List<UserFirebase>> _usersController = StreamController<List<UserFirebase>>.broadcast();

  Stream<List<ChatFirebase>> get chatStream => _chatController.stream;

  Stream<List<ChatMessage>> get chatMessageStream => _chatMessageController.stream;

  Stream<List<UserFirebase>> get usersStream => _usersController.stream;

  String lastMessageKey = '';

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
    on<EnterChatEvent>(_onEnterChatEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  Future<FutureOr<void>> _onChatInitialEvent(ChatInitialEvent event, Emitter<ChatState> emit) async {
    // chatRepository.createChat(
    //   creatorID: 5,
    //   chatName: 'testChat',
    //   memberIDs: ['5','6'],
    //   isGroup: false,
    // );

    // UserFirebase newUser = UserFirebase(
    //   userID: '5',
    //   username: 'JohnDoe',
    //   avatar: 'url_to_avatar',
    //   isOnline: true,
    // );

    // await chatRepository.addUserToFirebase(newUser);

    // chatRepository.sendMessage(
    //   chatID: 'asd',
    //   senderID: 5,
    //   text: 'asd',
    // );

    chatRepository.getUserChatsStream(userID: 5).listen((event) {
      _chatController.add(event);
    });

    chatRepository.getAllUsersStream().listen((event) {
      _usersController.add(event);
    });
  }

  String generateChatId() {
    DatabaseReference chatReference = FirebaseDatabase.instance.ref().child('chats');
    DatabaseReference newChatRef = chatReference.push();
    String chatId = newChatRef.key!;
    return chatId;
  }

  Future<void> _onEnterChatEvent(EnterChatEvent event, Emitter<ChatState> emit) async {
    _resetChatMessageController();
    final chatMessagesStream = chatRepository.getChatMessagesStream(chatId: event.chatId, startAtKey: lastMessageKey);
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

  Future<FutureOr<void>> _onSendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) async {
    ChatState entryState = state;
    try {
      chatRepository.sendMessage(event.chatId, 5, event.message);
      emit(const SendMessageStatus(true));
    } catch (e) {
      emit(const SendMessageStatus(false));
    }
    finally{
      emit(entryState);
    }
  }
}
