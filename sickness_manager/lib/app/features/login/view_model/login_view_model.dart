import 'package:sickness_manager/app/domain/repositories/user_repo.dart';

class LoginViewModel {
  LoginViewModel({required this.userRepo});

  final UserRepo userRepo;
}
