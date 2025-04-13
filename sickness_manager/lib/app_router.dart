import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sickness_manager/app/features/login/view_model/login_output.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_output.dart';
import 'package:sickness_manager/modules/absences_module.dart';
import 'package:sickness_manager/modules/login_module.dart';
import 'package:sickness_manager/modules/startup_module.dart';

class AppRouter implements StartupOutput, LoginOutput {
  late final router = GoRouter(
    observers: [CustomNavigatorObserver()],

    routes: [
      GoRoute(
        name: 'startup',
        path: '/',
        builder: (context, state) => StartupModule(),
      ),
      GoRoute(
        name: 'login',
        path: '/',
        builder: (context, state) => LoginModule(),
      ),
      GoRoute(
        name: 'absences',
        path: '/',
        builder: (context, state) => AbsencesModule(),
        
      ),
    ],
  );

  @override
  void goToLogin() {
    router.go('/login');
  }

  @override
  void goToAbsences() {
    router.go('/absences');
  }
}

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      log('Pushed route: ${route.settings.name}');
    }
  }
}
