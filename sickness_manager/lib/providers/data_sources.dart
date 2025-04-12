import 'package:riverpod/riverpod.dart';
import 'package:sickness_manager/app/core/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/core/data_sources/auth_data_source.dart';
import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';

final absencesDataSourceProvider = Provider<AbsencesDataSource>((ref) {
  return AbsencesDataSourceImpl();
});

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImpl();
});
