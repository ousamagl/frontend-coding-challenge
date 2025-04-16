import 'package:riverpod/riverpod.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
import 'package:sickness_manager/app/features/login/view_model/login_view_model.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_view_model.dart';
import 'package:sickness_manager/providers/navigation.dart';
import 'package:sickness_manager/providers/repositories.dart';

final absencesViewModelProvider = Provider.autoDispose<AbsencesViewModel>((
  ref,
) {
  final absencesRepo = ref.watch(absencesRepoProvider);
  final userRepo = ref.watch(userRepoProvider);
  final appRouter = ref.watch(appRouterProvider);

  return AbsencesViewModel(appRouter, absencesRepo, userRepo);
});

final loginViewModelProvider = Provider.autoDispose<LoginViewModel>((ref) {
  final userRepo = ref.watch(userRepoProvider);
  final absencesRepo = ref.watch(absencesRepoProvider);

  final appRouter = ref.watch(appRouterProvider);

  return LoginViewModel(appRouter, userRepo, absencesRepo);
});

final startupViewModel = Provider.autoDispose<StartupViewModel>((ref) {
  final userRepo = ref.watch(userRepoProvider);
  final absencesRepo = ref.watch(absencesRepoProvider);
  final appRouter = ref.watch(appRouterProvider);

  return StartupViewModel(appRouter, userRepo, absencesRepo);
});
