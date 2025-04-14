import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_output.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';

class AbsencesViewModel implements BaseViewModel<AbsencesState> {
  AbsencesViewModel(
    this._output,
    this._absencesRepo, {
    AbsencesState? initialState,
  }) : _state = ValueNotifier<AbsencesState>(
         initialState ?? const AbsencesState(),
       );

  final AbsencesOutput _output;
  final AbsencesRepo _absencesRepo;

  final ValueNotifier<AbsencesState> _state;

  @override
  ValueListenable<AbsencesState> get state => _state;

  @override
  void init() {
    fetchAbsences();
  }

  Future<void> fetchAbsences() async {
    _emit(execution: const Executing());
    await Future.delayed(const Duration(seconds: 2));
    _emit(
      execution: const Succeeded(),
      absences: [
        dummyAbsence,
        dummyAbsence,
        dummyAbsence,
        dummyAbsence,
        dummyAbsence,
        dummyAbsence,
        dummyAbsence,
        dummyAbsence,
      ],
    );
  }

  void _emit({Execution? execution, List<Absence>? absences}) =>
      _state.value = _state.value.copyWith(
        execution: execution,
        absences: absences,
      );

  @override
  void clear() {
    _state.value = const AbsencesState();
  }
}

final dummyAbsence = Absence(
  id: 1,
  userId: 3,
  crewId: 2,
  startDate: DateTime(2023, 10, 1),
  endDate: DateTime(2023, 10, 5),
  admitterId: 1,
  admitterNote: 'Admitted for medical reasons',
  confirmedAt: DateTime(2023, 10, 2),
  createdAt: DateTime(2023, 10, 1),
  memberNote: 'Member note',
  type: 'Sick Leave',
);
