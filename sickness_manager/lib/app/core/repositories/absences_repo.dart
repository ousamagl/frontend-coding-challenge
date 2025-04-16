import 'dart:async';

import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/statics.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';

class AbsencesRepoImpl implements AbsencesRepo {
  AbsencesRepoImpl({required this.absencesDataSource});

  final AbsencesDataSource absencesDataSource;

  final List<Absence?> _absences = [];
  final List<Member?> _members = [];
  int _offset = 0;
  int _absencesCount = 0;

  @override
  List<Absence?> get absences => _absences;

  @override
  List<Member?> get members => _members;

  @override
  int get absencesCount => _absencesCount;

  @override
  Future<void> init() async {
    final membersResult = await absencesDataSource.getMembers();
    _members.addAll(membersResult.valueOrNull ?? []);

    final absencesResult = await absencesDataSource.getAbsences(
      offset: _offset,
      limit: Statics.paginationLimit,
    );

    _absences.addAll(absencesResult.valueOrNull ?? []);

    await getAbsencesCount();
  }

  @override
  Future<Result<List<Absence?>>> getMoreAbsences({
    AbsenceType? type,
    AbsenceStatus? status,
    int? memberId,
    int? crewId,
    DateTime? startDate,
    DateTime? endDate,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      _offset = 0;
      _absences.clear();
    }

    if (!isRefresh) {
      _offset += Statics.paginationLimit;
    }

    final result = await absencesDataSource.getAbsences(
      offset: _offset,
      limit: Statics.paginationLimit,
      type: type,
      status: status,
      memberId: memberId,
      crewId: crewId,
      startDate: startDate,
      endDate: endDate,
    );

    return result.when(
      success: (absences) {
        final newAbsences =
            absences.where((absence) => !_doesAbsenceExist(absence)).toList();
        _absences.addAll(newAbsences);
        return Success(newAbsences);
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }

  bool _doesAbsenceExist(Absence? newAbsence) {
    return absences.any(
      (existingAbsence) => existingAbsence?.id == newAbsence?.id,
    );
  }

  @override
  Future<int> getAbsencesCount() async {
    _absencesCount = await absencesDataSource.getAbsencesCount();

    return _absencesCount;
  }

  @override
  void clear() {
    _absences.clear();
    _members.clear();
    _offset = 0;
  }
}
