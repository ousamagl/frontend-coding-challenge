import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/app/features/login/login_screen.dart';
import 'package:sickness_manager/providers/view_models.dart';

class LoginModule extends ConsumerStatefulWidget {
  const LoginModule({super.key});

  @override
  LoginModuleState createState() => LoginModuleState();
}

class LoginModuleState extends ConsumerState<LoginModule> {
  late final _viewModel = ref.read(loginViewModelProvider);

  @override
  Widget build(BuildContext context) {
    return LoginScreen(viewModel: _viewModel);
  }
}
