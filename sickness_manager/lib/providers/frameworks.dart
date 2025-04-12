import 'package:riverpod/riverpod.dart';
import 'package:sickness_manager/app/core/frameworks/storage.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';

final storageProvider = Provider<Storage>((ref) {
  return StorageImpl();
});