import 'package:mockito/annotations.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';

@GenerateNiceMocks([MockSpec<Storage>(), MockSpec<UserRepo>()])

// ignore: unused_import
import 'frameworks.mocks.dart';
