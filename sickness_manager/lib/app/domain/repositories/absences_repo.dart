import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';

abstract interface class AbsencesRepo {
  Future<void> init();

  Future<Result<List<Absence?>>> getMoreAbsences({
    AbsenceType? type,
    AbsenceStatus? status,
    int? memberId,
    int? crewId,
    DateTime? startDate,
    DateTime? endDate,
    bool isRefresh = false,
  });

  Future<int> getAbsencesCount();

  List<Absence?> get absences;

  List<Member?> get members;

  int get absencesCount;

  void clear();
}
