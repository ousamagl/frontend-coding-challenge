import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_state.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_view_model.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({required this.viewModel, super.key});

  final StartupViewModel viewModel;

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  StartupViewModel get _viewModel => widget.viewModel;

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
          backgroundColor: AppColors.primary,
          extendBody: true,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Absence Manager',
                    style: TextStyles.title.copyWith(color: AppColors.white),
                  ),
                  xlSpacer(),
                  defaultLoader(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: Dimensions.sm,
            margin: EdgeInsets.only(bottom: Dimensions.lg),
            child: Image.asset(Assets.logo),
          ),
        );
      },
    );
  }
}
