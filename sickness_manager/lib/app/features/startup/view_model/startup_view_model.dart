import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_output.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_state.dart';

class StartupViewModel implements BaseViewModel<StartupState> {
  StartupViewModel(
    this._output,
    this._userRepo,
    this._absencesRepo, {
    StartupState? initialState,
  }) : _state = ValueNotifier<StartupState>(
         initialState ?? const StartupState(),
       );

  final StartupOutput _output;
  final UserRepo _userRepo;
  final AbsencesRepo _absencesRepo;
  final ValueNotifier<StartupState> _state;

  @override
  ValueListenable<StartupState> get state => _state;

  @override
  void init() {
    checkForLoggedInUser();
  }

  Future<void> checkForLoggedInUser() async {
    _emit(execution: const Executing());
    final isLoggedIn = await _userRepo.isLoggedIn();

    if (isLoggedIn) {
      await _absencesRepo.init();

      _emit(execution: const Succeeded());
      _output.goToAbsences();
      return;
    }
    _output.goToLogin();
  }

  void _emit({Execution? execution}) =>
      _state.value = _state.value.copyWith(execution: execution);

  @override
  void clear() {
    _state.value = const StartupState();
  }
}
