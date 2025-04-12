import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_view_model.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key, required this.viewModel});

  final StartupViewModel viewModel;

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Startup')),
      body: Center(child: Text('Startup Screen')),
    );
  }
}
