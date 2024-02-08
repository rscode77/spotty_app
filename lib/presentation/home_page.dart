import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/pages.dart';
import 'package:spotty_app/presentation/bloc/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/events_bloc.dart';
import 'package:spotty_app/presentation/bloc/home_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/enums/navigation_bar_items_enum.dart';
import 'package:spotty_app/utils/extensions/multi_value_listenable_builder.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'pages/home/widgets/bottom_navigation_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;
  late final ChatBloc _chatBloc;
  late final EventsBloc _eventsBloc;

  final Map<NavigationBarItem, int> navigationBarItemIndex = {
    NavigationBarItem.map: 0,
    NavigationBarItem.mapSearch: 1,
    NavigationBarItem.events: 2,
    NavigationBarItem.users: 3,
    NavigationBarItem.chats: 4,
    NavigationBarItem.settings: 5,
  };

  final List<Widget> _pages = [
    Pages.map(),
    Pages.mapSearch(),
    Pages.events(),
    Pages.users(),
    Pages.chatsList(),
    Pages.settings(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  void _initializeBlocs() {
    _homeBloc = context.read<HomeBloc>();
    _chatBloc = context.read<ChatBloc>()..add(ChatInitialEvent());
    _eventsBloc = context.read<EventsBloc>()..add(const GetEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: BlocListener<LoginBloc, LoginState>(
        listener: _loginBlocListener,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => _pages[navigationBarItemIndex[state.currentTab] ?? 0],
        ),
      ),
    );
  }

  void _loginBlocListener(BuildContext context, LoginState state) {
    if (state is LoginInputState) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routing.login,
        (route) => false,
      );
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? DarkAppColors.background : LightAppColors.background,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPagePadding),
        child: MultiValueListenableBuilder(
          valueListenables: [
            _chatBloc.onlineUsersCount,
            _chatBloc.unreadMessagesCount,
          ],
          builder: (context, values) => _buildBottomNavigationBarWidget(values.cast<int>()),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarWidget(List<int> values) {
    int onlineUsersCount = values[0];
    int unreadMessagesCount = values[1];

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BottomNavigationBarWidget(
          onTabChanged: _onBottomNavigationBarItemPressed,
          isLocationEnabled: state.isLocationEnabled ?? false,
          eventsCount: 1,
          chatsCount: unreadMessagesCount,
          currentTab: state.currentTab == NavigationBarItem.mapSearch ? NavigationBarItem.map : state.currentTab,
          usersCount: onlineUsersCount,
        );
      },
    );
  }

  void _onBottomNavigationBarItemPressed(NavigationBarItem navigationBarItem) {
    _homeBloc.add(UpdateNavigationBarItemEvent(navigationBarItem: navigationBarItem));
  }
}
