import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/presentation/bloc/home/home_bloc.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/presentation/bloc/register/register_bloc.dart';
import 'package:spotty_app/presentation/pages/authentication/login_page.dart';
import 'package:spotty_app/presentation/pages/authentication/register_confirmation_page.dart';
import 'package:spotty_app/presentation/pages/authentication/register_page.dart';
import 'package:spotty_app/presentation/pages/home/home_page.dart';
import 'package:spotty_app/routing/route_constants.dart';
import 'package:spotty_app/services/common_storage.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: '/',
      path: RouteConstants.login,
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(),
      ),
      routes: [
        GoRoute(
          name: RouteConstants.register,
          path: RouteConstants.register,
          pageBuilder: (context, state) => MaterialPage(
            child: BlocProvider(
              create: (context) => RegisterBloc(
                userApiRepository: GetIt.instance.get<UserRepository>(),
              ),
              child: const RegisterPage(),
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      name: RouteConstants.registerConfirmation,
      path: RouteConstants.registerConfirmation,
      pageBuilder: (context, state) => const MaterialPage(
        child: RegisterConfirmationPage(),
      ),
    ),
    GoRoute(
      name: RouteConstants.home,
      path: RouteConstants.home,
      pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider(
          create: (context) => HomeBloc(
            loginBloc: context.read<LoginBloc>(),
            authRepository: GetIt.instance.get<AuthRepository>(),
            userRepository: GetIt.instance.get<UserRepository>(),
            commonStorage: GetIt.instance.get<CommonStorage>(),
          )..add(const GetCurrentUserData()),
          child: const HomePage(),
        ),
      ),
    ),
  ],
);
