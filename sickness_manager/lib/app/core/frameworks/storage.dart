import 'package:shared_preferences/shared_preferences.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';

class StorageImpl implements Storage {
  StorageImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> saveString(String key, String value) async =>
      await _sharedPreferences.setString(key, value);

  @override
  Future<String?> getString(String key) async =>
      _sharedPreferences.getString(key);

  @override
  Future<void> clear() async => await _sharedPreferences.clear();
}
