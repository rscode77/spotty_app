import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/presentation/bloc/home/home_bloc.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/presentation/pages/home/widgets/bottom_navigation_bar_widget.dart';
import 'package:spotty_app/presentation/pages/home/widgets/map_widget.dart';
import 'package:spotty_app/presentation/pages/home/widgets/profile_avatar_widget.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  String get username => _homeBloc.user.username.orEmpty();

  @override
  initState() {
    _homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: _homeBlocListener,
          builder: (_, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  void _homeBlocListener(BuildContext context, HomeState state) {}

  Widget _buildBody(HomeState state) {
    if (state is HomeLoading) {
      return _buildLoading();
    }
    return Stack(
      children: [
        MapWidget(mapController: state.mapController),
        _buildHeader(),
        _buildBottomNavigationBar(state),
      ],
    );
  }

  Widget _buildLoading() {
    return const LoadingWidget();
  }

  Widget _buildHeader() {
    return ProfileAvatarWidget(username: username);
  }

  Widget _buildBottomNavigationBar(HomeState state) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BottomNavigationBarWidget(
        onTabChanged: _onBottomNavigationBarItemPressed,
        isLocationEnabled: state.isUserLocationEnabled,
      ),
    );
  }

  void _onBottomNavigationBarItemPressed(NavigationBarItem navigationBarItem) {
    if (navigationBarItem == NavigationBarItem.location) {
      return _homeBloc.add(const SetUserLocationStatusEvent());
    }
    switch (navigationBarItem) {
      case NavigationBarItem.notifications:
        _homeBloc.add(const CenterMapOnUserLocationEvent());
        break;
      case NavigationBarItem.events:
        Navigator.pushNamed(context, Routing.events);
        break;
      case NavigationBarItem.chats:
        Navigator.pushNamed(context, Routing.chatsList);
        break;
      case NavigationBarItem.settings:
        Navigator.pushNamed(context, Routing.appSettings);
        break;
      default:
        break;
    }
  }
}
