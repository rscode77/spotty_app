import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/utils/enums/sending_status_enum.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatBloc _chatBloc;
  late final LoginBloc _loginBloc;
  late int _loggedInUserId;
  late double _screenWidth;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late ChatPageArguments? _args;

  StreamSubscription<List<ChatMessage>>? _chatMessageSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _initChat();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _chatBloc = context.read<ChatBloc>();
    _loginBloc = context.read<LoginBloc>();
    _loggedInUserId = _loginBloc.loggedInUserId;

    _chatMessageSubscription = _chatBloc.chatMessageStream.listen((chatData) {
      if (chatData.isNotEmpty) {
        _chatBloc.add(
          MarkMessageAsReadEvent(
            chatId: _args!.chatID,
            messageId: chatData.last.messageId,
          ),
        );
      }
    });

    Future.delayed(Duration.zero, () {
      SchedulerBinding.instance.addPostFrameCallback((_) => _scrollDownListView());
    });
  }

  @override
  void dispose() {
    _chatMessageSubscription?.cancel();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool _onScroll() {
    return _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
  }

  void _initChat() {
    _args = ModalRoute.of(context)!.settings.arguments as ChatPageArguments;
    _chatBloc.add(LoadMessagesEvent(chatId: _args!.chatID));
  }

  bool _isDarkTheme() => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        _onlineStatus(_args!.isOnline),
        const Space.horizontal(8.0),
        Text(_args!.chatName),
        const Space.horizontal(8.0),
      ],
    );
  }

  Widget _onlineStatus(bool isOnline) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isOnline ? AppColors.green : AppColors.gray,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<ChatBloc, ChatState>(
      listener: _chatStateListener,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return _buildChatStream();
        },
      ),
    );
  }

  Widget _buildChatStream() {
    return StreamBuilder<List<ChatMessage>>(
      initialData: const [],
      stream: _chatBloc.chatMessageStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return _buildChatList(snapshot.data ?? []);
        }
      },
    );
  }

  Widget _buildChatList(List<ChatMessage> chatData) {
    if (chatData.isNotEmpty) {
      _chatBloc.add(
        MarkMessageAsReadEvent(
          chatId: _args!.chatID,
          messageId: chatData.last.messageId,
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            controller: _scrollController,
            itemCount: chatData.length,
            itemBuilder: (context, index) {
              ChatMessage message = chatData[index];
              return _buildMessage(
                message.text,
                _isMe(message.senderID),
              );
            },
          ),
        ),
        const Divider(),
        _buildTextField(),
      ],
    );
  }

  void _chatStateListener(context, state) {
    if (state is SendMessageStatus) {
      if (state.status == SendingStatus.sent) {
        _messageController.clear();
      }
    }
  }

  void _scrollDownListView() {
    Future.delayed(Duration.zero, () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _isMe(int senderId) => senderId == _loggedInUserId;

  Widget _buildMessage(String message, bool isMe) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) _avatar(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            ),
            constraints: BoxConstraints(
              maxWidth: _screenWidth * 0.8,
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
          if (isMe) const Space.horizontal(AppDimensions.defaultPadding),
        ],
      ),
    );
  }

  Widget _avatar() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      width: 20,
      height: 20,
      child: const CircleAvatar(),
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        bool isSending = state is SendMessageStatus && state.status == SendingStatus.sending;
        return TextField(
          controller: _messageController,
          maxLines: null,
          minLines: 1,
          decoration: InputDecoration(
            hintText: S.of(context).writeMessage,
            suffixIcon: IconButton(
              icon: isSending ? const CircularProgressIndicator() : const Icon(Icons.send),
              onPressed: isSending ? null : _sendMessage,
            ),
          ),
        );
      },
    );
  }

  void _sendMessage() {
    _messageController.text = _messageController.text.removeExtraSpacesAndEmptyLines();
    if (_messageController.text.isEmpty) return;
    _chatBloc.add(
      SendMessageEvent(
        chatId: _args!.chatID,
        message: _messageController.text,
      ),
    );
  }
}