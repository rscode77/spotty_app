import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/firebase_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/domain/repositories/vehicle_repository.dart';
import 'package:spotty_app/presentation/bloc/profile_bloc.dart';
import 'package:spotty_app/presentation/bloc/register_bloc.dart';
import 'package:spotty_app/presentation/bloc/settings_bloc.dart';
import 'package:spotty_app/presentation/bloc/users_bloc.dart';
import 'package:spotty_app/presentation/bloc/vehicle_bloc.dart';
import 'package:spotty_app/presentation/home_page.dart';
import 'package:spotty_app/presentation/pages/authentication/register_page.dart';
import 'package:spotty_app/presentation/pages/home/chat/chat_page.dart';
import 'package:spotty_app/presentation/pages/home/chat/chats_list_page.dart';
import 'package:spotty_app/presentation/pages/home/events/event_details_page.dart';
import 'package:spotty_app/presentation/pages/home/map/map_page.dart';
import 'package:spotty_app/presentation/pages/home/map/map_search_page.dart';
import 'package:spotty_app/presentation/pages/home/settings/settings_page.dart';
import 'package:spotty_app/presentation/pages/home/users/users_page.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'presentation/bloc/home_bloc.dart';
import 'presentation/bloc/login_bloc.dart';
import 'presentation/pages/authentication/login_page.dart';
import 'presentation/pages/home/events/events_page.dart';
import 'presentation/pages/home/profile/profile_page.dart';

abstract class Pages {
  static Widget login() {
    return const LoginPage();
  }

  static Widget map() {
    return const MapPage();
  }

  static Widget events() {
    return const EventsPage();
  }

  static Widget eventDetails() {
    return const EventDetailsPage();
  }

  static Widget settings() {
    return const SettingsPage();
  }

  static Widget chatsList() {
    return const ChatsListPage();
  }

  static Widget chat() {
    return const ChatPage();
  }

  static Widget users() {
    return const UsersPage();
  }

  static Widget mapSearch() {
    return const MapSearchPage();
  }

  static Widget profilePage() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(
            loginBloc: context.read<LoginBloc>(),
            userApiRepository: GetIt.instance.get<UserRepository>(),
            vehicleApiRepository: GetIt.instance.get<VehicleRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => VehicleBloc(
            profileBloc: context.read<ProfileBloc>(),
            vehicleRepository: GetIt.instance.get<VehicleRepository>(),
          ),
        ),
      ],
      child: const ProfilePage(),
    );
  }

  static Widget mainPage() {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => HomeBloc(
          loginBloc: context.read<LoginBloc>(),
          authRepository: GetIt.instance.get<AuthRepository>(),
          commonStorage: GetIt.instance.get<CommonStorage>(),
          userRepository: GetIt.instance.get<UserRepository>(),
          firebaseRepository: GetIt.instance.get<FirebaseRepository>(),
        ),
      ),
      BlocProvider(
        create: (context) => UsersBloc(
          homeBloc: context.read<HomeBloc>(),
          chatRepository: GetIt.instance.get<FirebaseRepository>(),
          loginBloc: context.read<LoginBloc>(),
        ),
      ),
      BlocProvider(create: (context) => SettingsBloc()),
    ], child: const HomePage());
  }

  static Widget register() {
    return BlocProvider(
      create: (context) => RegisterBloc(
        userApiRepository: GetIt.instance.get<UserRepository>(),
      ),
      child: const RegisterPage(),
    );
  }
}
