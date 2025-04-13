import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_output.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_state.dart';

class StartupViewModel implements BaseViewModel<StartupState> {
  StartupViewModel(this._output, this._storage, {StartupState? initialState})
    : _state = ValueNotifier<StartupState>(
        initialState ?? const StartupState(),
      );

  final StartupOutput _output;
  final Storage _storage;

  final ValueNotifier<StartupState> _state;

  @override
  ValueListenable<StartupState> get state => _state;

  @override
  void init() {
    checkForLoggedInUser();
  }

  Future<void> checkForLoggedInUser() async {
    _emit(execution: const Executing());
    await Future.delayed(const Duration(seconds: 2));
    _output.goToAbsences();
  }

  void _emit({Execution? execution}) =>
      _state.value = _state.value.copyWith(execution: execution);

  @override
  void clear() {
    _state.value = const StartupState();
  }
}
