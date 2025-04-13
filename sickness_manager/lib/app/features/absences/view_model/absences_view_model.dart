import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';

class AbsencesViewModel implements BaseViewModel<AbsencesState> {
  AbsencesViewModel(this._absencesRepo, {AbsencesState? initialState})
    : _state = ValueNotifier<AbsencesState>(
        initialState ?? const AbsencesState(),
      );

  final AbsencesRepo _absencesRepo;

  final ValueNotifier<AbsencesState> _state;

  @override
  ValueListenable<AbsencesState> get state => _state;

  @override
  void init() {}

  void _emit({Execution? execution}) =>
      _state.value = _state.value.copyWith(execution: execution);

  @override
  void clear() {
    _state.value = const AbsencesState();
  }
}
