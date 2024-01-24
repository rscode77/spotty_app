import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  late final ChatBloc _chatBloc;
  late final LoginBloc _loginBloc;

  int get _loggedInUserId => _loginBloc.loggedInUserId;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
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
                  subtitle: Text('test'),
                  leading: _onlineStatus(chat.membersData),
                  onTap: () {
                    _chatBloc.add(EnterChatEvent(chatId: chat.chatID));
                    Navigator.of(context).pushNamed(
                      Routing.chatPage,
                      arguments: ChatPageArguments(
                        chatId: chat.chatID,
                        members: chat.membersData,
                        isNewChat: false,
                        chatName: chat.name,
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

  Widget _onlineStatus(List<UserFirebase> members) {
    int userId = members.firstWhere((member) => member.userId.toInt() != _loggedInUserId).userId.toInt();
    return StreamBuilder<List<UserFirebase>>(
      stream: _chatBloc.usersStream,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          var user = snapshot.data!.firstWhere((member) => member.userId.toInt() == userId);
          if (user.isOnline) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              width: 10,
              height: 10,
              child: const CircleAvatar(
                backgroundColor: Colors.green,
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}