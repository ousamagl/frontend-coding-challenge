import 'package:riverpod/riverpod.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
import 'package:sickness_manager/app/features/login/view_model/login_view_model.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_view_model.dart';
import 'package:sickness_manager/providers/frameworks.dart';
import 'package:sickness_manager/providers/navigation.dart';
import 'package:sickness_manager/providers/repositories.dart';

final absencesViewModelProvider = Provider.autoDispose<AbsencesViewModel>((
  ref,
) {
  final absencesRepo = ref.watch(absencesRepoProvider);

  return AbsencesViewModel(absencesRepo);
});

final loginViewModelProvider = Provider.autoDispose<LoginViewModel>((ref) {
  final userRepo = ref.watch(userRepoProvider);

  return LoginViewModel(userRepo);
});

final startupViewModel = Provider.autoDispose<StartupViewModel>((ref) {
  final storage = ref.watch(storageProvider);
  final router = ref.watch(appRouterProvider);

  return StartupViewModel(router, storage);
});
