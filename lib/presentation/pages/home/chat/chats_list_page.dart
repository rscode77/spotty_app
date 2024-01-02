import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/user_chat_data_model.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<List<UserChats>>(
        stream: _chatBloc.chatStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<UserChats> chatData = snapshot.data ?? [];
            return ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                UserChats chat = chatData[index];
                return ListTile(
                  title: Text('Chat ${chat.lastMessage}'),
                  onTap: () {
                    // Navigate to chat page
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}