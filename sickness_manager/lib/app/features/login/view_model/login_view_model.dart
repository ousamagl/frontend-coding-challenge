import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';
import 'package:sickness_manager/app/features/login/view_model/login_state.dart';

class LoginViewModel implements BaseViewModel<LoginState> {
  LoginViewModel(this._userRepo, {LoginState? initialState})
    : _state = ValueNotifier<LoginState>(initialState ?? const LoginState());

  final UserRepo _userRepo;

  final ValueNotifier<LoginState> _state;

  @override
  ValueListenable<LoginState> get state => _state;

  @override
  void init() {}

  void _emit({Execution? execution}) =>
      _state.value = _state.value.copyWith(execution: execution);

  @override
  void clear() {
    _state.value = const LoginState();
  }
}
