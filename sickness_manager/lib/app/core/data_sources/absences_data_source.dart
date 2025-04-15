import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';

class AbsencesDataSourceImpl implements AbsencesDataSource {
  @override
  Future<List<Absence?>> getAbsences() async {
    return [];
  }

  @override
  Future<List<Member?>> getMembers() async {
    return [];
  }
}
