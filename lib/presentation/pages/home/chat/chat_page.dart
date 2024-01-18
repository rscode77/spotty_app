import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatBloc _chatBloc;
  late final ChatPageArguments _args;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isScrolledToTop()) {
      print('scroll');
      context.read<ChatBloc>().add(
            LoadMoreMessagesEvent(
              chatId: _args.chatId,
              startAtKey: _chatBloc.lastMessageKey,
            ),
          );
    }
  }

  bool _isScrolledToTop() {
    return _scrollController.position.pixels == _scrollController.position.minScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as ChatPageArguments;
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
    _scrollListView();
    List<ChatMessage> chatData = snapshot.data ?? [];
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: chatData.length,
            itemBuilder: (context, index) {
              ChatMessage message = chatData[index];
              return _buildMessage(message.text);
            },
          ),
        ),
        const Divider(),
        _buildTextField(),
      ],
    );
  }

  void _scrollListView(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessage(String message) {
    return Text(message);
  }

  Widget _buildTextField() {
    return TextField(
      controller: _messageController,
      decoration: InputDecoration(
        hintText: 'Enter a message',
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            _chatBloc.add(
              SendMessageEvent(
                chatId: _args.chatId,
                message: _messageController.text,
              ),
            );
          },
        ),
      ),
    );
  }
}
