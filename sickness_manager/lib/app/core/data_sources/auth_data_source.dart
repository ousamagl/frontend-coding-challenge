import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';
import 'package:sickness_manager/app/domain/models/user.dart';

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    return null;
  }

  @override
  Future<bool> logout() async {
    return true;
  }

  @override
  Stream<User> currentUserStream() => Stream<User>.empty();
}
