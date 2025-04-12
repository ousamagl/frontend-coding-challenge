import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/app/features/startup/startup_screen.dart';
import 'package:sickness_manager/providers/view_models.dart';

class StartupModule extends ConsumerStatefulWidget {
  const StartupModule({super.key});

  @override
  StartupModuleState createState() => StartupModuleState();
}

class StartupModuleState extends ConsumerState<StartupModule> {
  late final _viewModel = ref.read(startupViewModel);

  @override
  Widget build(BuildContext context) {
    return StartupScreen(viewModel: _viewModel);
  }
}
