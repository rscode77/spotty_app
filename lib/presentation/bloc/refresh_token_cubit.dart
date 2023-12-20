import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';

class AuthCubit extends Cubit<bool> {
  late CommonStorage _commonStorage;
  late Timer _refreshTokenTimer;

  AuthCubit() : super(false) {
    _initRefreshTokenTimer();
  }

  void _initRefreshTokenTimer() {
    _refreshTokenTimer = Timer.periodic(const Duration(minutes: 15), (_) {
      refreshAccessToken();
    });
  }

  void refreshAccessToken() {
    _commonStorage.putString(CommonStorageKeys.accessToken, 'newAccessToken');
    _commonStorage.putString(CommonStorageKeys.refreshToken, 'newRefreshToken');
  }

  @override
  Future<void> close() {
    _refreshTokenTimer.cancel();
    return super.close();
  }
}