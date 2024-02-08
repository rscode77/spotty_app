import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/domain/repositories/firebase_repository.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/enums/sending_status_enum.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseRepository chatRepository;
  final LoginBloc loginBloc;

  List<UserFirebase>? _usersData;
  List<ChatFirebase>? _chatData;

  int messageLimit = Constants.messageLimit;

  final ValueNotifier<int> _onlineUsersCount = ValueNotifier(0);
  final ValueNotifier<int> _unreadMessagesCount = ValueNotifier(0);

  final StreamController<List<ChatFirebase>> _chatController = StreamController<List<ChatFirebase>>.broadcast();
  final StreamController<List<UserFirebase>> _usersController = StreamController<List<UserFirebase>>.broadcast();

  StreamController<List<ChatMessage>> _chatMessageController = StreamController<List<ChatMessage>>.broadcast();

  Stream<List<ChatFirebase>> get chatStream => _chatController.stream;

  Stream<List<ChatMessage>> get chatMessageStream => _chatMessageController.stream;

  Stream<List<UserFirebase>> get usersStream => _usersController.stream;

  List<UserFirebase> get usersData => _usersData ?? [];

  List<ChatFirebase> get chatData => _chatData ?? [];

  ValueNotifier<int> get onlineUsersCount => _onlineUsersCount;

  ValueNotifier<int> get unreadMessagesCount => _unreadMessagesCount;

  ChatBloc({
    required this.chatRepository,
    required this.loginBloc,
  }) : super(ChatInitial()) {
    on<ChatInitialEvent>(_onChatInitialEvent);
    on<EnterChatEvent>(_onEnterChatEvent);
    on<LoadMessagesEvent>(_loadMessagesEvent);
    on<LoadMoreMessagesEvent>(_onLoadMoreMessagesEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<MarkMessageAsReadEvent>(_onMarkMessageAsReadEvent);
  }

  Future<void> _onChatInitialEvent(ChatInitialEvent event, Emitter<ChatState> emit) async {
    _listenToAllUsersStream();
    _listenToUserChatsStream();
  }

  void _listenToAllUsersStream() {
    chatRepository.getAllUsersStream().listen((users) {
      _updateUsersData(users);
    });
  }

  void _listenToUserChatsStream() {
    chatRepository.getUserChatsStream(userID: loginBloc.loggedInUserId).listen((chats) {
      _updateChatData(chats);
    });
  }

  Future<void> _onEnterChatEvent(EnterChatEvent event, Emitter<ChatState> emit) async {
    _resetChatMessageController();
    if (event.lastMessageId != null) {
      add(MarkMessageAsReadEvent(chatId: event.chatId, messageId: event.lastMessageId.orEmpty()));
    }
  }

  Future<void> _onLoadMoreMessagesEvent(LoadMoreMessagesEvent event, Emitter<ChatState> emit) async {
    messageLimit += Constants.messageLimit;
    await _loadChatMessages(event.chatId);
  }

  Future<void> _loadMessages(String chatId) async {
    messageLimit = Constants.messageLimit;
    await _loadChatMessages(chatId);
  }

  void _resetChatMessageController() {
    _chatMessageController.close();
    _chatMessageController = StreamController<List<ChatMessage>>.broadcast();
  }

  Future<void> _onSendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) async {
    ChatState entryState = state;
    emit(const SendMessageStatus(SendingStatus.sending));
    try {
      await chatRepository.sendMessage(
        chatID: event.chatId,
        senderID: loginBloc.loggedInUserId,
        message: event.message,
      );
      await Future.delayed(const Duration(milliseconds: 200));
      emit(const SendMessageStatus(SendingStatus.sent));
    } catch (e) {
      emit(const SendMessageStatus(SendingStatus.failed));
    } finally {
      emit(entryState);
    }
  }

  void _updateUsersData(List<UserFirebase> users) {
    _usersData = users;
    _usersData?.sort((a, b) {
      var onlineComparison = b.isOnline ? 1 : 0 - (a.isOnline ? 1 : 0);
      if (onlineComparison != 0) {
        return onlineComparison;
      }
      return b.lastActivity.compareTo(a.lastActivity);
    });
    _onlineUsersCount.value = _calculateOnlineUsersCount(users);
    _usersController.add(users);

    _updateChatData(chatData);
  }

  Future<void> _updateChatData(List<ChatFirebase> chats) async {
    _chatData = chats;
    _unreadMessagesCount.value = _calculateUnreadMessagesCount(chats);
    _sortChatData();
    _updateChatMembersData();
    _chatController.add(chats);
  }

  void _sortChatData() {
    _chatData?.sort((a, b) {
      int timestampA = a.lastMessageTimestamp ?? 0;
      int timestampB = b.lastMessageTimestamp ?? 0;
      return timestampB.compareTo(timestampA);
    });
  }

  void _updateChatMembersData() {
    _chatData?.forEach((chat) {
      if (chat.isGroup) {
        _updateGroupChatMembersData(chat);
      } else {
        _updateSingleChatMembersData(chat);
      }
    });
  }

  void _updateGroupChatMembersData(ChatFirebase chat) {
    for (var member in chat.members) {
      if (member != loginBloc.loggedInUserId) {
        if (_usersData == null) return;
        chat.membersData.add(_usersData!.where((user) => user.userId.toInt() == member).first);
      }
    }
    chat.isOnline = chat.membersData.any((user) => user.isOnline);
  }

  void _updateSingleChatMembersData(ChatFirebase chat) {
    for (var member in chat.members) {
      if (member != loginBloc.loggedInUserId) {
        if (_usersData == null) return;
        UserFirebase user = _usersData!.firstWhere((user) => user.userId.toInt() == member);
        chat.name = user.username;
        chat.isOnline = user.isOnline;
      }
    }
  }

  Future<void> _loadChatMessages(String chatId) async {
    final chatMessagesStream = chatRepository.getChatMessagesStream(
      chatId: chatId,
      limit: messageLimit,
    );
    await for (final chatMessages in chatMessagesStream) {
      _chatMessageController.add(chatMessages);
    }
  }

  void _onMarkMessageAsReadEvent(MarkMessageAsReadEvent event, Emitter<ChatState> emit) {
    if (event.messageId.isNullOrBlank) return;
    chatRepository.markMessageAsRead(
      chatId: event.chatId,
      messageId: event.messageId.orEmpty(),
      userId: loginBloc.loggedInUserId,
    );
  }

  void _loadMessagesEvent(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) {
    _loadMessages(event.chatId);
  }

  int _calculateOnlineUsersCount(List<UserFirebase> users) {
    return users.where((user) => user.userId != loginBloc.loggedInUserId.toString() && user.isOnline).length;
  }

  int _calculateUnreadMessagesCount(List<ChatFirebase> chats) {
    return chats.where((messages) => messages.isLastMessageRead == false && messages.lastMessageId != null).length;
  }

  @override
  Future<void> close() {
    _chatController.close();
    _chatMessageController.close();
    _usersController.close();
    return super.close();
  }
}
