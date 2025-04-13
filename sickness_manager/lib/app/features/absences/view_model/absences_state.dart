import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';

@immutable
class AbsencesState extends Equatable {
  const AbsencesState({this.execution = const Idle()});

  final Execution execution;

  AbsencesState copyWith({Execution? execution}) {
    return AbsencesState(execution: execution ?? this.execution);
  }

  @override
  List<Object?> get props => [execution];
}
