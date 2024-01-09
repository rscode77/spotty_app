import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/domain/repositories/chat_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  final StreamController<List<ChatFirebase>> _chatController = StreamController<List<ChatFirebase>>.broadcast();

  Stream<List<ChatFirebase>> get chatStream => _chatController.stream;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
    on<EnterChatEvent>(_onEnterChatEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  FutureOr<void> _onChatInitialEvent(ChatInitialEvent event, Emitter<ChatState> emit) {
    chatRepository.createChat(
      creatorID: 5,
      chatName: 'testChat',
      memberIDs: ['5','6'],
      isGroup: false,
    );
    // chatRepository.sendMessage(
    //   chatID: 'asd',
    //   senderID: 5,
    //   text: 'asd',
    // );

    chatRepository.getUserChatsStream(userID: 5).listen((event) {
      _chatController.add(event);
    });
  }

  String generateChatId() {
    DatabaseReference chatReference = FirebaseDatabase.instance.ref().child('chats');
    DatabaseReference newChatRef = chatReference.push();
    String chatId = newChatRef.key!;
    return chatId;
  }

  FutureOr<void> _onEnterChatEvent(EnterChatEvent event, Emitter<ChatState> emit) {}

  @override
  Future<void> close() {
    _chatController.close();
    return super.close();
  }

  FutureOr<void> _onSendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) {

  }
}
