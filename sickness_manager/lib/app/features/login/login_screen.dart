import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/login/view_model/login_state.dart';
import 'package:sickness_manager/app/features/login/view_model/login_view_model.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.viewModel, super.key});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  LoginViewModel get _viewModel => widget.viewModel;
  LoginState get _state => _viewModel.state.value;

  @override
  void initState() {
    super.initState();
    widget.viewModel.init();
  }

  @override
  void dispose() {
    widget.viewModel.clear();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LoginState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return _body();
      },
    );
  }

  Widget _body() => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smSpacer(),
            ..._header(),
            xlSpacer(),
            ..._loginForm(),
            smSpacer(),
            Divider(endIndent: Dimensions.md, indent: Dimensions.md),
            smSpacer(),
            _loginButton(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: Dimensions.sm,
        margin: EdgeInsets.only(bottom: Dimensions.lg),
        child: Image.asset(Assets.logo),
      ),
    ),
  );

  List<Widget> _header() => [
    Padding(
      padding: Paddings.horizontalMd,
      child: Text(
        'Welcome back',
        style: TextStyles.title.copyWith(color: AppColors.white),
      ),
    ),
    xsSpacer(),
    Padding(
      padding: Paddings.horizontalMd,
      child: Text(
        'Please login to your account',
        style: TextStyles.body.copyWith(color: AppColors.white),
      ),
    ),
  ];

  List<Widget> _loginForm() => [
    CustomTextField(
      labelText: 'Email',
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      onChanged: (email) => _viewModel.onEmailChanged(email),
      errorText: _state.emailError.isEmpty ? null : _state.emailError,
    ),
    smSpacer(),
    CustomTextField(
      labelText: 'Password',
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      obscureText: true,
      onChanged: (password) => _viewModel.onPasswordChanged(password),
      errorText: _state.passwordError.isEmpty ? null : _state.passwordError,
    ),
  ];

  Widget _loginButton() => Padding(
    padding: Paddings.horizontalMd,
    child: primaryFilledButton(
      'Admin Login',
      isLoading: _state.execution.isExecuting,
      onPressed:
          _state.passwordError.isEmpty && _state.emailError.isEmpty
              ? () {
                _viewModel.login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }
              : null,
    ),
  );
}
