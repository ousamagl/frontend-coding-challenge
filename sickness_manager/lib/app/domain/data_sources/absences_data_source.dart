import 'package:sickness_manager/app/domain/models/absence.dart';

abstract interface class AbsencesDataSource {
  Future<List<Absence?>> getAbsences();

  Future<bool> updateAbsence({required String absenceId});
}
