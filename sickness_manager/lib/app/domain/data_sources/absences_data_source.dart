import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';

abstract interface class AbsencesDataSource {
  Future<List<Absence?>> getAbsences();

  Future<List<Member?>> getMembers();
}
