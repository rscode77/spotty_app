import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/presentation/bloc/home/home_bloc.dart';
import 'package:spotty_app/spotty_app.dart';

class AppBlocObserver extends BlocObserver with WidgetsBindingObserver {
  final HomeBloc homeBloc;

  AppBlocObserver({required this.homeBloc}) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if(homeBloc.isUserLoggedIn){
        try{
          homeBloc.add(const RefreshTokenEvent());
        } catch (e) {
          runApp(const SpottyApp());
        }
      }
    }
  }
}
