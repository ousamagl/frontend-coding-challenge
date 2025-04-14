import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';

@immutable
class AbsencesState extends Equatable {
  const AbsencesState({
    this.execution = const Idle(),
    this.absences = const [],
  });

  final Execution execution;
  final List<Absence> absences;

  AbsencesState copyWith({Execution? execution, List<Absence>? absences}) {
    return AbsencesState(
      execution: execution ?? this.execution,
      absences: absences ?? this.absences,
    );
  }

  @override
  List<Object?> get props => [execution, absences];
}
