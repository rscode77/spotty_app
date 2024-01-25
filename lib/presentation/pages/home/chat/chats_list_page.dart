import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

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
        title: Text(S.of(context).message),
      ),
      body: StreamBuilder<List<ChatFirebase>>(
        stream: _chatBloc.chatStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ChatFirebase> chatData = snapshot.data ?? [];
            return _buildChat(chatData);
          }
        },
      ),
    );
  }

  Widget _buildChat(List<ChatFirebase> chat) {
    return ListView.builder(
      itemCount: chat.length,
      itemBuilder: (context, index) {
        ChatFirebase message = chat[index];
        return InkWell(
          onTap: () => _onTapChat(message),
          child: Row(
            children: [
              const Space.horizontal(10.0),
              _onlineStatus(message.isOnline),
              const Space.horizontal(16.0),
              SizedBox(
                height: AppDimensions.height.chatHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(message),
                    _buildLastMessage(message),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle(ChatFirebase message) {
    return Text(
      message.name,
      style: AppTextStyles.chatTitle().copyWith(
        fontWeight: message.isLastMessageRead ? FontWeight.normal : FontWeight.bold,
      ),
    );
  }

  Widget _buildLastMessage(ChatFirebase message) {
    return Row(
      children: [
        Text(
          message.lastMessage,
          style: AppTextStyles.chatMessage().copyWith(
            fontWeight: message.isLastMessageRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        Text(
          ' · ${message.lastMessageTimestamp.toChatTime()}',
          style: AppTextStyles.chatMessage().copyWith(
            fontWeight: message.isLastMessageRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _onTapChat(ChatFirebase message) {
    Navigator.of(context).pushNamed(
      Routing.chatPage,
      arguments: ChatPageArguments(
        chatID: message.chatID,
        chatName: message.name,
        isOnline: message.isOnline,
        members: message.membersData,
      ),
    );
    _chatBloc.add(
      EnterChatEvent(chatId: message.chatID),
    );
    _chatBloc.add(
      MarkMessageAsReadEvent(
        chatId: message.chatID,
        messageId: message.lastMessageId,
      ),
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
}