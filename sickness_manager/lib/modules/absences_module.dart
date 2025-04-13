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
  AbsencesModuleState createState() => AbsencesModuleState();
}

class AbsencesModuleState extends ConsumerState<AbsencesModule> {
  late final _viewModel = ref.read(absencesViewModelProvider);
  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: 'absences-list',
        path: '/list',
        builder: (context, state) => AbsencesScreen(viewModel: _viewModel),
      ),
      GoRoute(
        name: 'absence-detail',
        path: '/detail/:id',
        builder: (context, state) {
          return AbsenceDetailsScreen(viewModel: _viewModel);
        },
      ),
      GoRoute(
        name: 'absences-filters',
        path: '/filters',
        builder:
            (context, state) => AbsencesFilterScreen(viewModel: _viewModel),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Router(routerDelegate: _router.routerDelegate);
  }
}
