import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/providers/navigation.dart';

class AppModule extends ConsumerStatefulWidget {
  const AppModule({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppModuleState();
}

class _AppModuleState extends ConsumerState<AppModule> {
  late final appRouter = ref.read(appRouterProvider);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sickness Manager',
      routerConfig: appRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
