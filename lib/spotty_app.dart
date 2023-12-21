import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/routing/routing.dart';
import 'firebase_options.dart';

import 'presentation/bloc/login/login_bloc.dart';
import 'services/common_storage.dart';

class SpottyApp extends StatefulWidget {
  const SpottyApp({Key? key}) : super(key: key);

  @override
  State<SpottyApp> createState() => _SpottyAppState();
}

class _SpottyAppState extends State<SpottyApp> {
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _initLoginBloc();
    _initializeFirebase();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _initLoginBloc() {
    _loginBloc = LoginBloc(
      authRepository: GetIt.instance.get<AuthRepository>(),
      commonStorage: GetIt.instance.get<CommonStorage>(),
      userApiRepository: GetIt.instance.get<UserRepository>(),
    )..add(const LoginInitialEvent());
  }

  void _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginBloc,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => S.of(context).login,
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          S.delegate,
        ],
      ),
    );
  }
}