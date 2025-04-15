import 'package:sickness_manager/app/core/common/types/result.dart';

abstract interface class AuthDataSource {
  Future<Result<String?>> login({
    required String username,
    required String password,
  });
}
