import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotty_app/domain/repositories/auth_repository.dart';
import 'package:spotty_app/domain/repositories/chat_repository.dart';
import 'package:spotty_app/domain/repositories/event_repository.dart';
import 'package:spotty_app/domain/repositories/user_repository.dart';
import 'package:spotty_app/manager/dio_manager.dart';
import 'package:spotty_app/services/common_storage.dart';

import 'services/users_location_service.dart';

class Injector {
  static final Injector _instance = Injector._();

  static final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  GetIt get getIt => GetIt.instance;

  factory Injector() {
    _instance._init();
    return _instance;
  }

  Injector._();

  void _init() {
    DioManager dio = DioManager();
    getIt.registerLazySingleton<CommonStorage>(() => CommonStorage(sharedPreferences: _sharedPreferences));
    getIt.registerLazySingleton<UserLocationService>(() => UserLocationService());
    getIt.registerLazySingleton<UserRepository>(() => UserRepository(dio: dio.dio));
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(dio: dio.dio));
    getIt.registerLazySingleton<EventRepository>(() => EventRepository(dio: dio.dio));
    getIt.registerLazySingleton<MapController>(() => MapController());
    getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
  }
}
