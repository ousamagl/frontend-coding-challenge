import 'package:sickness_manager/app/core/common/types/result.dart';

abstract interface class UserRepo {
  Future<Result<String?>> login({
    required String username,
    required String password,
  });

  Future<bool> logout();

  Future<bool> isLoggedIn();
}
