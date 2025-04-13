import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sickness_manager/app/features/absences/absence_details_screen.dart';
import 'package:sickness_manager/app/features/absences/absences_filters_screen.dart';
import 'package:sickness_manager/app/features/absences/absences_screen.dart';
import 'package:sickness_manager/providers/view_models.dart';

class AbsencesModule extends ConsumerStatefulWidget {
  const AbsencesModule({super.key});

  @override
  LoginModuleState createState() => LoginModuleState();
}

class LoginModuleState extends ConsumerState<AbsencesModule> {
  late final _viewModel = ref.read(absencesViewModelProvider)..init();

  late final _localRouter = GoRouter(
    initialLocation: '/absences',
    routes: [
      GoRoute(
        path: '/absences',
        builder: (_, __) => AbsencesScreen(viewModel: _viewModel),
      ),
      GoRoute(
        name: 'absence-details',
        path: '/details/:id',
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return AbsenceDetailsScreen(viewModel: _viewModel);
        },
      ),
      GoRoute(
        name: 'absence-filters',
        path: '/absences/filters',
        builder: (_, __) => AbsencesFilterScreen(viewModel: _viewModel),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _localRouter.routerDelegate,
      routeInformationParser: _localRouter.routeInformationParser,
      routeInformationProvider: _localRouter.routeInformationProvider,
      backButtonDispatcher: _localRouter.backButtonDispatcher,
    );
  }

  @override
  void dispose() {
    _viewModel.clear();
    super.dispose();
  }
}
