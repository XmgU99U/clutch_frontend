import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static CacheHelper? _instance;

  CacheHelper._internal();

  factory CacheHelper() {
    _instance ??= CacheHelper._internal();
    return _instance!;
  }
  late final SharedPreferences _sharedPref;

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  String? getString(String key) => _sharedPref.getString(key);

  int? getInt(String key) => _sharedPref.getInt(key);

  double? getDouble(String key) => _sharedPref.getDouble(key);

  bool? getBool(String key) => _sharedPref.getBool(key);

  Future<bool> setString(String key, String value) async {
    print('DATA SETTED TO CACHE');
    print('key: $key | value: $value');
    return _sharedPref.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    print('DATA SETTED TO CACHE');
    print('key: $key | value: $value');
    return _sharedPref.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    print('DATA SETTED TO CACHE');
    print('key: $key | value: $value');
    return _sharedPref.setDouble(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    print('DATA SETTED TO CACHE');
    print('key: $key | value: $value');
    return _sharedPref.setBool(key, value);
  }

  Future<bool> delete(String key) async {
    return await _sharedPref.remove(key);
  }

  Future<bool> clear() async {
    return await _sharedPref.clear();
  }
}
