import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/app/features/absences/absences_screen.dart';
import 'package:sickness_manager/providers/view_models.dart';

class AbsencesModule extends ConsumerStatefulWidget {
  const AbsencesModule({super.key});

  @override
  AbsencesModuleState createState() => AbsencesModuleState();
}

class AbsencesModuleState extends ConsumerState<AbsencesModule> {
  late final _viewModel = ref.read(absencesViewModelProvider);

  @override
  Widget build(BuildContext context) {
    return AbsencesScreen(viewModel: _viewModel);
  }
}
