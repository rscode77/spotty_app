import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_search_bar.dart';
import 'package:spotty_app/presentation/common/widgets/user_avatar_status.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
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

  final TextEditingController _searchController = TextEditingController();

  int get _loggedInUserId => _loginBloc.loggedInUserId;

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _chatBloc = context.read<ChatBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<ChatBloc, ChatState>(
        listener: _chatBlocListener,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPagePadding),
          child: _buildBody(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: Constants.centerAppBar,
      title: Text(
        S.of(context).messages,
        style: AppTextStyles.appBarTitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
      elevation: 0.0,
    );
  }

  void _chatBlocListener(BuildContext context, ChatState state) {}

  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        const Space.vertical(AppDimensions.defaultPadding),
        Expanded(
          child: StreamBuilder<List<ChatFirebase>>(
            initialData: _chatBloc.chatData,
            stream: _chatBloc.chatStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<ChatFirebase> chatData = snapshot.data ?? [];
                return _buildChat(chatData);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return AppSearchBar(
      isDarkTheme: _isDarkTheme,
      hint: S.of(context).findChat,
      searchController: _searchController,
      onSubmitted: (string) {},
    );
  }

  Widget _buildChat(List<ChatFirebase> chat) {
    return ListView.builder(
      itemCount: chat.length,
      itemBuilder: (context, index) {
        ChatFirebase message = chat[index];
        if (message.lastMessageId.isNullOrBlank) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: _buildChatItem(message),
        );
      },
    );
  }

  Widget _buildChatItem(ChatFirebase message) {
    return SizedBox(
      height: 60.0,
      child: InkWell(
        onTap: () => _onTapChat(message),
        child: Row(
          children: [
            UserAvatarStatus(
              isOnline: message.isOnline,
              avatar: 'assets/images/profile_avatar.png',
              isDarkTheme: _isDarkTheme,
            ),
            const Space.horizontal(8.0),
            Expanded(
              // Add this
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(ChatFirebase message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          message.name.orEmpty(),
          style: AppTextStyles.chatTitle().copyWith(
            fontWeight: message.isLastMessageRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:10.0),
          child: Text(
            message.lastMessageTimestamp!.toChatTime(),
            style: AppTextStyles.chatMessage().copyWith(
              color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
              fontWeight: message.isLastMessageRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastMessage(ChatFirebase message) {
    if (message.lastMessage == null) return const SizedBox.shrink();
    bool isLastMessageRead = message.isLastMessageRead;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          message.lastMessage.orEmpty(),
          style: AppTextStyles.chatMessage().copyWith(
            fontWeight: message.isLastMessageRead ? FontWeight.normal : FontWeight.bold,
            color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
          ),
        ),
        isLastMessageRead ? const SizedBox.shrink() : _buildUnreadIcon(isLastMessageRead),
      ],
    );
  }

  Widget _buildUnreadIcon(bool isMessageRead) {
    return Container(
      height: 18.0,
      width: 18.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.blue,
      ),
      child: const Icon(
        Icons.mark_email_unread_outlined,
        size: 12,
        color: AppColors.white,
      ),
    );
  }

  Future<void> _onTapChat(ChatFirebase message) async {
    _chatBloc.add(EnterChatEvent(
      chatId: message.chatID,
      lastMessageId: message.lastMessageId,
    ));
    Navigator.of(context).pushNamed(
      Routing.chatPage,
      arguments: ChatPageArguments(
        avatar: message.avatar,
        chatID: message.chatID,
        chatName: message.name.orEmpty(),
        isOnline: message.isOnline,
        members: message.membersData,
        lastMessageId: message.lastMessageId,
      ),
    );
  }
}