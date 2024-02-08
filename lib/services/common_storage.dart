import 'package:shared_preferences/shared_preferences.dart';

class CommonStorage {
  final Future<SharedPreferences> sharedPreferences;

  const CommonStorage({required this.sharedPreferences});

  Future<String?> getString(String key, {
    String? defaultValue,
  }) async =>
      (await sharedPreferences).getString(key) ?? defaultValue;

  Future<bool> putString(String key, String value) async => (await sharedPreferences).setString(key, value);

  void removeKey(String key) async => (await sharedPreferences).remove(key);

  Future<int?> getInt(String key, {
    int? defaultValue,
  }) async =>
      (await sharedPreferences).getInt(key) ?? defaultValue;

  Future<bool> putInt(String key, int value) async => (await sharedPreferences).setInt(key, value);

  Future<bool?> getBool(String key, {
    bool? defaultValue,
  }) async =>
      (await sharedPreferences).getBool(key) ?? defaultValue;

  Future<bool> putBool(String key, bool value) async => (await sharedPreferences).setBool(key, value);

  Future<List<String>?> getStringList(String key, {
    List<String>? defaultValue,
  }) async =>
      (await sharedPreferences).getStringList(key) ?? defaultValue;

  Future<bool> putStringList(String key, List<String> value) async => (await sharedPreferences).setStringList(key, value);
}