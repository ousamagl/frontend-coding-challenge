import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';

abstract interface class AbsencesDataSource {
  Future<Result<List<Absence?>>> getAbsences({
    int offset = 0,
    int limit = 10,
    AbsenceType? type,
    AbsenceStatus? status,
    int? memberId,
    int? crewId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<int> getAbsencesCount();

  Future<Result<List<Member?>>> getMembers();
}
