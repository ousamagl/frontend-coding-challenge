import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  UserRepoImpl({required this.authDataSource, required this.storage});

  final AuthDataSource authDataSource;
  final Storage storage;

  @override
  Future<Result<String?>> login({
    required String username,
    required String password,
  }) async {
    final result = await authDataSource.login(
      username: username,
      password: password,
    );

    return result.when(
      success: (token) async {
        final token = result.valueOrNull;

        await storage.saveString(tokenKey, token ?? '');

        return Success(token);
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }

  @override
  Future<bool> logout() async {
    try {
      await storage.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await storage.getString(tokenKey);
    return token != null && token.isNotEmpty;
  }
}

const tokenKey = 'access_token';
