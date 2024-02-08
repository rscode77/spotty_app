import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ThemeState {
  final bool isThemeDark;
  ThemeState(this.isThemeDark);
}

class ThemeCubit extends Cubit<ThemeState> {
  final CommonStorage commonStorage;

  ThemeCubit({required this.commonStorage}) : super(ThemeState(false)) {
    initializeThemeFromStorage();
  }

  Future<void> initializeThemeFromStorage() async {
    bool isDarkTheme = await commonStorage.getBool(CommonStorageKeys.isThemeDark) ?? true;
    emit(ThemeState(isDarkTheme));
  }

  void toggleTheme() {
    bool newThemeState = !state.isThemeDark;
    emit(ThemeState(newThemeState));
    commonStorage.putBool(CommonStorageKeys.isThemeDark, newThemeState);
  }
}