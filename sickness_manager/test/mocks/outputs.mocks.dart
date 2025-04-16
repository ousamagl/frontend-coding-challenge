import 'package:mockito/annotations.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_output.dart';
import 'package:sickness_manager/app/features/login/view_model/login_output.dart';
import 'package:sickness_manager/app/features/startup/view_model/startup_output.dart';

@GenerateNiceMocks([
  MockSpec<AbsencesOutput>(),
  MockSpec<StartupOutput>(),
  MockSpec<LoginOutput>(),
])
// ignore: unused_import
import 'outputs.mocks.dart';
