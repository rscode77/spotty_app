import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/event_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/presentation/bloc/home/events_bloc.dart';
import 'package:spotty_app/presentation/bloc/home/settings_bloc.dart';
import 'package:spotty_app/presentation/pages/home/chat/chat_page.dart';
import 'package:spotty_app/presentation/pages/home/chat/chats_list_page.dart';
import 'package:spotty_app/presentation/pages/home/home_page.dart';
import 'package:spotty_app/presentation/pages/home/settings/settings_page.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/users_location_service.dart';

import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/login/login_bloc.dart';
import 'presentation/pages/authentication/login_page.dart';
import 'presentation/pages/home/events/events_page.dart';

abstract class Pages {
  static Widget login() {
    return const LoginPage();
  }

  static Widget home() {
    return BlocProvider(
      create: (context) => HomeBloc(
        loginBloc: context.read<LoginBloc>(),
        authRepository: GetIt.instance.get<AuthRepository>(),
        commonStorage: GetIt.instance.get<CommonStorage>(),
        userRepository: GetIt.instance.get<UserRepository>(),
        userLocationService: GetIt.instance.get<UserLocationService>(),
        mapController: GetIt.instance.get<MapController>(),
      )..add(const GetCurrentUserDataEvent()),
      child: const HomePage(),
    );
  }

  static Widget events() {
    return BlocProvider(
        create: (context) => EventsBloc(
              eventRepository: GetIt.instance.get<EventRepository>(),
            )..add(const GetEvents()),
        child: const EventsPage());
  }

  static Widget settings() {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: const SettingsPage(),
    );
  }

  static Widget chatsList() {
    return const ChatsListPage();
  }

  static Widget chat() {
    return const ChatPage();
  }
}
