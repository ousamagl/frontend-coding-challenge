import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setSupportedOrientations();

  runApp(ProviderScope(child: const AppModule()));
}

Future<void> _setSupportedOrientations() =>
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
