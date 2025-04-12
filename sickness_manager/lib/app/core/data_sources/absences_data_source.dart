import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';

class AbsencesDataSourceImpl implements AbsencesDataSource {
  @override
  Future<List<Absence?>> getAbsences() async {
    return [];
  }

  @override
  Future<bool> updateAbsence({required String absenceId}) async {
    return true;
  }
}
