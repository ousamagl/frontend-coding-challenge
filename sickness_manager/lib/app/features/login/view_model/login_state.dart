import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';

@immutable
class LoginState extends Equatable {
  const LoginState({
    this.execution = const Idle(),
    this.email = '',
    this.password = '',
    this.emailError = '',
    this.passwordError = '',
    this.didValidate = false,
  });

  final Execution execution;
  final String email;
  final String password;
  final String emailError;
  final String passwordError;
  final bool didValidate;

  LoginState copyWith({
    Execution? execution,
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? didValidate,
  }) {
    return LoginState(
      execution: execution ?? this.execution,
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      didValidate: didValidate ?? this.didValidate,
    );
  }

  @override
  List<Object?> get props => [
    execution,
    email,
    password,
    emailError,
    passwordError,
    didValidate,
  ];
}
