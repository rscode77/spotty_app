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
        stream: context.read<ChatBloc>().chatStream,
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
                  title: Text(chat.membersData[0].username),
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
      stream: context.read<ChatBloc>().usersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // display a loading indicator
        }
        if (snapshot.hasError) {
          print('Stream error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data != null) {
          // use snapshot.data here
        }
        return const SizedBox.shrink();
      },
    );
  }
}
