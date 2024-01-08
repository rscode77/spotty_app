import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatBloc _chatBloc;
  late final ChatPageArguments _args;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>();
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as ChatPageArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<List<ChatFirebase>>(
      stream: _chatBloc.chatStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return _buildChat(snapshot);
        }
      },
    );
  }

  Widget _buildChat(snapshot) {
    List<ChatFirebase> chatData = snapshot.data ?? [];
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: chatData.length,
          itemBuilder: (context, index) {
            ChatFirebase message = chatData[index];
            return _buildMessage('');
          },
        ),
        const Spacer(),
        _buildTextField(),
      ],
    );
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
            _chatBloc.add(SendMessageEvent(
              chatId: _args.chatId,
              toUserid: 5,
              isNewChat: _args.isNewChat,
              message: _messageController.text,
            ));
          },
        ),
      ),
    );
  }
}
