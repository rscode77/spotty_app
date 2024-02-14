import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/chat_firebase_model.dart';
import 'package:spotty_app/data/models/chat_page_arguments.dart';
import 'package:spotty_app/data/models/user_firebase_model.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/home_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/presentation/bloc/users_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_icon_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_search_bar.dart';
import 'package:spotty_app/presentation/common/widgets/user_avatar_status.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late final ChatBloc _chatBloc;
  late final LoginBloc _loginBloc;
  late final UsersBloc _usersBloc;
  late final HomeBloc _homeBloc;

  final TextEditingController _searchController = TextEditingController();

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  initState() {
    _chatBloc = context.read<ChatBloc>();
    _loginBloc = context.read<LoginBloc>();
    _usersBloc = context.read<UsersBloc>();
    _homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPagePadding),
        child: BlocListener<UsersBloc, UsersState>(
          listener: _chatBlocListener,
          child: _buildBody(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: Constants.centerAppBar,
      title: Text(
        S.of(context).users,
        style: AppTextStyles.appBarTitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
      elevation: 0.0,
    );
  }

  void _chatBlocListener(BuildContext context, UsersState state) {
    if (state is ChatExistsState) {
      if (state.chat != null) {
        ChatFirebase chat = state.chat!;
        _chatBloc.add(EnterChatEvent(
          chatId: chat.chatID,
          lastMessageId: chat.lastMessageId,
        ));
        Navigator.of(context).pushNamed(
          Routing.chatPage,
          arguments: ChatPageArguments(
            avatar: chat.avatar,
            chatID: chat.chatID,
            chatName: state.user.username,
            isOnline: state.user.isOnline,
            members: chat.membersData,
            lastMessageId: chat.lastMessageId,
          ),
        );
      } else {}
    }
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        const Space.vertical(AppDimensions.defaultPadding),
        Expanded(
          child: StreamBuilder<List<UserFirebase>>(
            stream: _chatBloc.usersStream,
            initialData: _chatBloc.usersData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return _buildUserList(snapshot.data!);
              } else {
                return const Text('No data');
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
      hint: S.of(context).findUser,
      searchController: _searchController,
      onSubmitted: (string) {},
    );
  }

  bool isMe(String userId) => userId == _loginBloc.loggedInUserId.toString();

  Widget _buildUserList(List<UserFirebase> user) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24.0),
            itemCount: user.length,
            itemBuilder: (context, index) {
              if (isMe(user[index].userId)) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: _buildUser(user[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUser(UserFirebase user) {
    return SizedBox(
      height: 60.0,
      child: Row(
        children: [
          UserAvatarStatus(
            isOnline: user.isOnline,
            avatar: 'assets/images/profile_avatar.png',
            isDarkTheme: _isDarkTheme,
          ),
          const Space.horizontal(8.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the widgets vertically
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUsername(user),
              _buildVehicle(user),
              _buildLastActivity(user),
            ],
          ),
          const Spacer(),
          _buildLastLocation(user),
          _buildSendMessageButton(user),
          const Space.horizontal(6.0),
        ],
      ),
    );
  }

  Widget _buildUsername(UserFirebase user) {
    return Text(
      user.username,
      style: AppTextStyles.chatTitle(
        color: _isDarkTheme ? DarkAppColors.dark : LightAppColors.dark,
      ),
    );
  }

  Widget _buildLastLocation(UserFirebase user) {
    if (user.longitude == null || user.latitude == null) return const SizedBox.shrink();
    return AppIconButton(
      icon: LucideIcons.locateFixed,
      iconSize: 20.0,
      color: AppColors.blue,
      onPressed: () => {
        _homeBloc.add(
          NavigateToLocationEvent(
            location: LatLng(
              user.latitude!.toDouble(),
              user.longitude!.toDouble(),
            ),
          ),
        ),
      },
    );
  }

  Widget _buildSendMessageButton(UserFirebase user) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is CreatingNewChatState && state.userId == user.userId.toInt()) {
            return const LoadingWidget(
              size: 40.0,
              strokeWidth: 3.0,
            );
          }
          return _buildMessageButton(user);
        },
      ),
    );
  }

  Widget _buildMessageButton(UserFirebase user) {
    return AppIconButton(
      iconSize: 20.0,
      icon: LucideIcons.mailPlus,
      color: AppColors.blue,
      onPressed: () => _usersBloc.add(
        CheckChatExistsEvent(user: user),
      ),
    );
  }

  Widget _buildVehicle(UserFirebase user) {
    if (user.vehicle.isNullOrBlank) return const SizedBox.shrink();
    return Text(
      user.vehicle.orEmpty(),
      style: AppTextStyles.chatMessage(
        color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
      ),
    );
  }

  Widget _buildLastActivity(UserFirebase user) {
    return Text(
      user.lastActivity.toChatTime(),
      style: AppTextStyles.chatMessage(
        color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
      ),
    );
  }
}
