import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotty_app/domain/repositories/user_api_repository.dart';
import 'package:spotty_app/endpoints.dart';
import 'package:spotty_app/services/common_storage.dart';

class Injector {
  static final Injector _instance = Injector._();
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      contentType: 'application/json',
    ),
  );

  static final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  GetIt get getIt => GetIt.instance;

  factory Injector() {
    _instance._init();
    return _instance;
  }

  Injector._();

  void _init() {
    getIt.registerLazySingleton<CommonStorage>(() => CommonStorage(sharedPreferences: _sharedPreferences));
    getIt.registerLazySingleton<UserApiRepository>(() => UserApiRepository(dio: _dio));
  }
}
