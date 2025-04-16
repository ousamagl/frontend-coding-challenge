import 'package:riverpod/riverpod.dart';
import 'package:sickness_manager/app/core/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/core/data_sources/auth_data_source.dart';
import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';
import 'package:sickness_manager/providers/frameworks.dart';

final absencesDataSourceProvider = Provider<AbsencesDataSource>((ref) {
  final storage = ref.watch(storageProvider);
  return AbsencesDataSourceImpl(storage: storage);
});

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImpl();
});
