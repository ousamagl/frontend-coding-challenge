import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sickness_manager/app_module.dart';
import 'package:sickness_manager/providers/frameworks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setSupportedOrientations();
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.reload();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const AppModule(),
    ),
  );
}

Future<void> _setSupportedOrientations() =>
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
