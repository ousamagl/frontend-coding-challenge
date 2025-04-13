import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';

@immutable
class LoginState extends Equatable {
  const LoginState({this.execution = const Idle()});

  final Execution execution;

  LoginState copyWith({Execution? execution}) {
    return LoginState(execution: execution ?? this.execution);
  }

  @override
  List<Object?> get props => [execution];
}
