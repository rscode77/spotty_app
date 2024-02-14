import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/chat_message.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_icon_button.dart';
import 'package:spotty_app/presentation/common/widgets/user_avatar_status.dart';
import 'package:spotty_app/utils/enums/sending_status_enum.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

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

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      actions: [
        _buildLeadingRow(),
        const Space.horizontal(16.0),
        Text(_args!.chatName),
        const Spacer(),
        _buildMoreIconButton(),
        const Space.horizontal(8.0),
      ],
    );
  }

  Widget _buildLeadingRow() {
    return Row(
      children: [
        const Space.horizontal(8.0),
        _buildBackIconButton(),
        const Space.horizontal(8.0),
        _buildUserAvatarStatus(),
      ],
    );
  }

  Widget _buildBackIconButton() {
    return AppIconButton(
      onPressed: () => Navigator.pop(context),
      icon: LucideIcons.arrowLeft,
      color: _isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
    );
  }

  Widget _buildMoreIconButton() {
    return AppIconButton(
      onPressed: () {},
      icon: LucideIcons.moreVertical,
      color: _isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
    );
  }

  Widget _buildUserAvatarStatus() {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: UserAvatarStatus(
        avatar: _args!.avatar.orEmpty(),
        isOnline: _args!.isOnline,
        isDarkTheme: _isDarkTheme,
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
            padding: const EdgeInsets.only(
              bottom: 24.0,
            ),
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
        _buildTextField(),
        const Space.vertical(16.0),
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: TextField(
                  style: AppTextStyles.chatMessage(
                    color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 12.0),
                    hintText: S.of(context).chatTypeMessage,
                    hintStyle: AppTextStyles.chatMessage(
                      color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1,
                        color: _isDarkTheme ? DarkAppColors.border : LightAppColors.border,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1,
                        color: _isDarkTheme ? DarkAppColors.border : LightAppColors.border,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14.0),
                      ),
                    ),
                  ),
                  controller: _messageController,
                  maxLines: null,
                  minLines: 1,
                ),
              ),
            ),
            const Space.horizontal(16.0),
            _buildSendButton(),
          ],
        );
      },
    );
  }

  Widget _buildSendButton() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return InkWell(
          onTap: _sendMessage,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: const Icon(
              size: 18.0,
              LucideIcons.forward,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  //bool isSending = state is SendMessageStatus && state.status == SendingStatus.sending;
  //onPressed: isSending ? null : _sendMessage,

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