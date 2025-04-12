import 'package:sickness_manager/app/domain/frameworks/storage.dart';

class StorageImpl implements Storage {
  @override
  Future<void> saveString(String key, String value) async {}

  @override
  Future<String?> getString(String key) async {
    return null;
  }

  @override
  Future<void> clear() async {}
}
