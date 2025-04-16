import 'package:mockito/annotations.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';

@GenerateNiceMocks([MockSpec<AbsencesRepo>(), MockSpec<UserRepo>()])
// ignore: unused_import
import 'repositories.dart';
