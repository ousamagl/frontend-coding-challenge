import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_state.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_view_model.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({required this.viewModel, super.key});

  final StartupViewModel viewModel;

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  StartupViewModel get _viewModel => widget.viewModel;

  StartupState get _state => _viewModel.state.value;

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StartupState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Startup')),
          body: Center(child: Text('startup screen')),
        );
      },
    );
  }
}
