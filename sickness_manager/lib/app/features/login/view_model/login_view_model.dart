import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';
import 'package:sickness_manager/app/features/login/view_model/login_output.dart';
import 'package:sickness_manager/app/features/login/view_model/login_state.dart';

class LoginViewModel implements BaseViewModel<LoginState> {
  LoginViewModel(this._output, this._userRepo, {LoginState? initialState})
    : _state = ValueNotifier<LoginState>(initialState ?? const LoginState());

  final UserRepo _userRepo;
  final LoginOutput _output;

  final ValueNotifier<LoginState> _state;

  @override
  ValueListenable<LoginState> get state => _state;

  @override
  void init() {}

  Future<void> login({required String email, required String password}) async {
    _emit(
      execution: const Executing(),
      email: email,
      password: password,
      didValidate: true,
    );

    final isEmailValid = _validateEmail(email);
    final isPasswordValid = _validatePassword(password);

    if (!isEmailValid || !isPasswordValid) {
      _emit(execution: Failed());
      return;
    }

    final result = await _userRepo.login(
      username: _state.value.email,
      password: _state.value.password,
    );

    result.when(
      success: (token) {
        _emit(execution: const Succeeded());
        _output.goToAbsences();
      },
      failure: (error) {
        _emit(execution: Failed());
        _emit(emailError: error);
      },
    );
  }

  void onEmailChanged(String? email) {
    _emit(email: email);
    _validateEmail(email);
    _validatePassword(_state.value.password);
  }

  void onPasswordChanged(String? password) {
    _emit(password: password);
    _validateEmail(_state.value.email);
    _validatePassword(password);
  }

  bool _validateEmail(String? username) {
    if (!state.value.didValidate) return true;

    _emit(email: username, emailError: '');

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (username == null || username.isEmpty) {
      _emit(emailError: 'Email cannot be empty');
      return false;
    } else if (!emailRegex.hasMatch(username)) {
      _emit(emailError: 'Please enter a valid email');
      return false;
    } else {
      _emit(emailError: '');
      return true;
    }
  }

  bool _validatePassword(String? password) {
    if (!state.value.didValidate) return true;

    _emit(password: password, passwordError: '');
    if (password == null || password.isEmpty) {
      _emit(passwordError: 'Password cannot be empty');
      return false;
    } else {
      _emit(passwordError: '');
      return true;
    }
  }

  void _emit({
    Execution? execution,
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? didValidate,
  }) =>
      _state.value = _state.value.copyWith(
        execution: execution,
        email: email,
        password: password,
        emailError: emailError,
        passwordError: passwordError,
        didValidate: didValidate,
      );

  @override
  void clear() {
    _state.value = const LoginState();
  }
}
