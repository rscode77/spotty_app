import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';
import 'package:spotty_app/routing/routing.dart';

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
    _chatBloc = context.read<ChatBloc>()..add(ChatInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<List<ChatFirebase>>(
        stream: _chatBloc.chatStream,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ChatFirebase> chatData = snapshot.data ?? [];
            return ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                ChatFirebase chat = chatData[index];
                return ListTile(
                  title: Text(chat.name),
                  onTap: () {
                    _chatBloc.add(EnterChatEvent(chatId: chat.chatID));
                    Navigator.of(context).pushNamed(
                      Routing.chatPage,
                      arguments: ChatPageArguments(
                        chatId: chat.chatID,
                        members: chat.membersData,
                        isNewChat: false,
                      ),
                    );
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