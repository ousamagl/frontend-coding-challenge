import 'package:mockito/annotations.dart';
import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';

@GenerateNiceMocks([MockSpec<AbsencesDataSource>(), MockSpec<AuthDataSource>()])
// ignore: unused_import
import 'data_sources.mocks.dart';
