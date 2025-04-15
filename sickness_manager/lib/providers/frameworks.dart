import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sickness_manager/app/core/frameworks/storage.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';

final storageProvider = Provider<Storage>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);

  return StorageImpl(sharedPreferences);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
