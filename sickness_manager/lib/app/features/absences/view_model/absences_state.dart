import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';

@immutable
class AbsencesState extends Equatable {
  const AbsencesState({
    this.execution = const Idle(),
    this.currentPage = const [],
    this.members = const [],
    this.absencesCount = 0,
    this.paginationIndex = 0,
    this.typeFilter = AbsenceType.none,
    this.statusFilter = AbsenceStatus.none,
    this.startDateFilter,
    this.endDateFilter,
    this.memberIdFilter = -1,
    this.crewIdFilter = -1,
  });

  final Execution execution;
  final List<Absence?> currentPage;
  final List<Member?> members;
  final int absencesCount;
  final int paginationIndex;

  ///Filters
  final AbsenceType typeFilter;
  final AbsenceStatus statusFilter;
  final DateTime? startDateFilter;
  final DateTime? endDateFilter;
  final int memberIdFilter;
  final int crewIdFilter;

  AbsencesState copyWith({
    Execution? execution,
    List<Absence?>? currentPage,
    List<Member?>? members,
    int? absencesCount,
    int? paginationIndex,
    AbsenceType? typeFilter,
    AbsenceStatus? statusFilter,
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    int? memberIdFilter,
    int? crewIdFilter,
    bool? clearStartDate,
    bool? clearEndDate,
  }) {
    return AbsencesState(
      execution: execution ?? this.execution,
      currentPage: currentPage ?? this.currentPage,
      members: members ?? this.members,
      absencesCount: absencesCount ?? this.absencesCount,
      paginationIndex: paginationIndex ?? this.paginationIndex,
      typeFilter: typeFilter ?? this.typeFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      startDateFilter:
          clearStartDate == true
              ? null
              : startDateFilter ?? this.startDateFilter,
      endDateFilter:
          clearEndDate == true ? null : endDateFilter ?? this.endDateFilter,
      memberIdFilter: memberIdFilter ?? this.memberIdFilter,
      crewIdFilter: crewIdFilter ?? this.crewIdFilter,
    );
  }

  @override
  List<Object?> get props => [
    execution,
    currentPage,
    members,
    absencesCount,
    paginationIndex,
    typeFilter,
    statusFilter,
    startDateFilter,
    endDateFilter,
    memberIdFilter,
    crewIdFilter,
  ];
}
