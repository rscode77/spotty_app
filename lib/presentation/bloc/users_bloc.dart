import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/domain/repositories/firebase_repository.dart';
import 'package:spotty_app/presentation/bloc/home_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final FirebaseRepository chatRepository;
  final LoginBloc loginBloc;
  final HomeBloc homeBloc;

  UsersBloc({
    required this.chatRepository,
    required this.loginBloc,
    required this.homeBloc,
  }) : super(UsersInitial()) {
    on<CheckChatExistsEvent>(_onCheckChatExistsEvent);
  }

  Future<ChatFirebase?> _getChat(
    int loggedInUserId,
    int otherUserId,
  ) async {
    return await chatRepository.getChat(
      loggedInUserId: loggedInUserId,
      otherUserId: otherUserId,
    );
  }

  Future<ChatFirebase?> _createChat(
    int loggedInUserId,
    int otherUserId,
  ) async {
    await chatRepository.createChat(
      creatorID: loggedInUserId,
      chatName: '',
      memberIDs: [
        loggedInUserId,
        otherUserId,
      ],
      isGroup: false,
    );
    return await _getChat(
      loggedInUserId,
      otherUserId,
    );
  }

  Future<FutureOr<void>> _onCheckChatExistsEvent(
    CheckChatExistsEvent event,
    Emitter<UsersState> emit,
  ) async {
    UsersState previousState = state;
    try {
      emit(
        CreatingNewChatState(
          userId: event.user.userId.toInt(),
        ),
      );
      ChatFirebase? chat = await _getChat(
        loginBloc.loggedInUserId,
        event.user.userId.toInt(),
      );
      chat ??= await _createChat(
        loginBloc.loggedInUserId,
        event.user.userId.toInt(),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ChatExistsState(
        chat: chat,
        user: event.user,
      ));
    } catch (e) {
      debugPrint('Error checking chat exists: $e');
    } finally {
      emit(previousState);
    }
  }
}
