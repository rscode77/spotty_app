import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/event_repository.dart';
import 'package:spotty_app/domain/repositories/firebase_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/theme_cubit.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/styles/theme.dart';

import 'presentation/bloc/events_bloc.dart';
import 'presentation/bloc/login_bloc.dart';
import 'services/common_storage.dart';

class SpottyApp extends StatefulWidget {
  const SpottyApp({Key? key}) : super(key: key);

  @override
  State<SpottyApp> createState() => _SpottyAppState();
}

class _SpottyAppState extends State<SpottyApp> {
  late final ThemeCubit _themeCubit;
  late final LoginBloc _loginBloc;
  late final ChatBloc _chatBloc;
  late final EventsBloc _eventsBloc;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    _initInitialBloc();
    _initLoginBloc();
    _initChatBloc();
    _initEventsBloc();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: _themeCubit.state.isThemeDark ? Brightness.light : Brightness.dark,
    ));
  }

  void _initInitialBloc() {
    _themeCubit = ThemeCubit(commonStorage: GetIt.instance.get<CommonStorage>());
  }

  void _initLoginBloc() {
    _loginBloc = LoginBloc(
      authRepository: GetIt.instance.get<AuthRepository>(),
      commonStorage: GetIt.instance.get<CommonStorage>(),
      userApiRepository: GetIt.instance.get<UserRepository>(),
    );
  }

  void _initChatBloc() {
    _chatBloc = ChatBloc(
      loginBloc: _loginBloc,
      chatRepository: GetIt.instance.get<FirebaseRepository>(),
    );
  }

  void _initEventsBloc() {
    _eventsBloc = EventsBloc(
      loginBloc: _loginBloc,
      eventRepository: GetIt.instance.get<EventRepository>(),
    );
  }

  ThemeData _themeData() {
    return lightMode;
    return _themeCubit.state.isThemeDark ? darkMode : lightMode;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _loginBloc),
        BlocProvider.value(value: _chatBloc),
        BlocProvider.value(value: _eventsBloc),
      ],
      child: MaterialApp(
        theme: _themeData(),
        initialRoute: Routing.login,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => S.of(context).login,
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          S.delegate,
        ],
        onGenerateRoute: Routing.getMainRoute,
      ),
    );
  }
}
