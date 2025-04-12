import 'package:riverpod/riverpod.dart';
import 'package:sickness_manager/app/core/repositories/absences_repo.dart';
import 'package:sickness_manager/app/core/repositories/user_repo.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';
import 'package:sickness_manager/providers/data_sources.dart';

final absencesRepoProvider = Provider<AbsencesRepo>((ref) {
  final absencesDataSource = ref.watch(absencesDataSourceProvider);

  return AbsencesRepoImpl(absencesDataSource: absencesDataSource);
});

final userRepoProvider = Provider<UserRepo>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);

  return UserRepoImpl(authDataSource: authDataSource);
});
