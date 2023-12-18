import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spotty_app/authentication/login/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/authentication/login/presentation/pages/login_page.dart';
import 'package:spotty_app/services/common_storage.dart';

abstract class Pages {
  static Widget login() {
    return BlocProvider(
      create: (context) => LoginBloc(
        commonStorage: GetIt.instance.get<CommonStorage>(),
        userApiRepository: GetIt.instance.get<UserApiRepository>(),
      )..add(const LoginInitialEvent()),
      child: const LoginPage(),
    );
  }
}
