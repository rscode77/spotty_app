import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
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
  late final ChatPageArguments _args;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _chatBloc = context.read<ChatBloc>();
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.loggedInUserId.then((value) => _loggedInUserId = value.orZero());

    Future.delayed(Duration.zero, () {
      _screenWidth = MediaQuery.of(context).size.width;
      _args = ModalRoute.of(context)!.settings.arguments as ChatPageArguments;
      SchedulerBinding.instance.addPostFrameCallback((_) => _scrollDownListView());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrolledToTop()) {
      _chatBloc.add(
        LoadMoreMessagesEvent(
          chatId: _args.chatId,
        ),
      );
    }
  }

  bool _isScrolledToTop() {
    return _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocListener<ChatBloc, ChatState>(
      listener: _chatStateListener,
      child: StreamBuilder<List<ChatMessage>>(
        stream: _chatBloc.chatMessageStream,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return _buildChat(snapshot);
          }
        },
      ),
    );
  }

  void _chatStateListener(context, state) {
    if (state is SendMessageStatus) {
      if (state.status) {
        _messageController.clear();
      }
    }
  }

  Widget _buildChat(snapshot) {
    List<ChatMessage> chatData = snapshot.data ?? [];
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
    return TextField(
      controller: _messageController,
      maxLines: null,
      minLines: 1,
      decoration: InputDecoration(
        hintText: S.of(context).writeMessage,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: _sendMessage,
        ),
      ),
    );
  }

  void _sendMessage(){
    _messageController.text = _messageController.text.removeExtraSpacesAndEmptyLines();
    if(_messageController.text.trim().isEmpty) return;
    _chatBloc.add(
      SendMessageEvent(
        chatId: _args.chatId,
        message: _messageController.text,
      ),
    );
  }
}
