import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  UserRepoImpl({required this.authDataSource});

  final AuthDataSource authDataSource;
}
