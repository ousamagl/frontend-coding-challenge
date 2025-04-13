import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/providers/navigation.dart';

class AppModule extends ConsumerWidget {
  const AppModule({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'Sickness Manager',
      routerConfig: appRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
