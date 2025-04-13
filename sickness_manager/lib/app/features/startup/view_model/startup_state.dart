import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';

@immutable
class StartupState extends Equatable {
  const StartupState({this.execution = const Idle()});

  final Execution execution;

  StartupState copyWith({Execution? execution}) {
    return StartupState(
      execution: execution ?? this.execution,
    );
  }

  @override
  List<Object?> get props => [execution];
}
