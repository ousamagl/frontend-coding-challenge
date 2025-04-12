import 'package:sickness_manager/app/domain/models/user.dart';

abstract interface class AuthDataSource {
  Future<User?> login({required String username, required String password});

  Future<bool> logout();

  Stream<User?> currentUserStream();
}
