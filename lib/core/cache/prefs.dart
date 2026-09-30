import 'package:shared_preferences/shared_preferences.dart';

abstract interface class Prefs {
  String? getString(String key);
  Future<bool> setString({
    required String key,
    required String value
  });

  int? getInt(String key);
  Future<bool> setInt({
    required String key,
    required int value
  });

  Future<bool> remove(String key);

  Future<bool> clear();
}

final class const PrefsImpl(this._prefs) implements Prefs{
  final SharedPreferences _prefs;

  @override
  String? getString(String key)
  => _prefs.getString(key);

  @override
  Future<bool> setString({
    required String key,
    required String value
  })
  => _prefs.setString(key, value);

  @override
  int? getInt(String key)
  => _prefs.getInt(key);

  @override
  Future<bool> setInt({
    required String key,
    required int value
  })
  => _prefs.setInt(key, value);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);

  @override
  Future<bool> clear() => _prefs.clear();
}