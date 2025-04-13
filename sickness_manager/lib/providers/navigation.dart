import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sickness_manager/app_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));
