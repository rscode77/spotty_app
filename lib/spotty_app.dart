import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/chat_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';
import 'package:spotty_app/routing/routing.dart';

import 'presentation/bloc/login/login_bloc.dart';
import 'services/common_storage.dart';

class SpottyApp extends StatefulWidget {
  const SpottyApp({Key? key}) : super(key: key);

  @override
  State<SpottyApp> createState() => _SpottyAppState();
}

class _SpottyAppState extends State<SpottyApp> {
  late final LoginBloc _loginBloc;
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp()  {
    _initLoginBloc();
    _initChatBloc();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      chatRepository: GetIt.instance.get<ChatRepository>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _loginBloc),
        BlocProvider.value(value: _chatBloc),
      ],
      child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
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
