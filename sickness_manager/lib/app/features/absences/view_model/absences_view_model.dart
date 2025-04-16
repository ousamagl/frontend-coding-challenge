import 'package:flutter/foundation.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/statics.dart';
import 'package:sickness_manager/app/core/common/types/base_view_model.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';
import 'package:sickness_manager/app/domain/repositories/user_repo.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_output.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';

class AbsencesViewModel implements BaseViewModel<AbsencesState> {
  AbsencesViewModel(
    this._output,
    this._absencesRepo,
    this._userRepo, {
    AbsencesState? initialState,
  }) : _state = ValueNotifier<AbsencesState>(
         initialState ?? const AbsencesState(),
       );

  final AbsencesOutput _output;
  final AbsencesRepo _absencesRepo;
  final UserRepo _userRepo;

  final ValueNotifier<AbsencesState> _state;

  @override
  ValueListenable<AbsencesState> get state => _state;

  @override
  void init() {
    _loadAbsencesIfNecessary();
  }

  Future<void> _loadAbsencesIfNecessary() async {
    if (_absencesRepo.absences.isEmpty) {
      _emit(execution: Executing());
      await _absencesRepo.init();
      _emit(execution: Succeeded());
    }

    final totalAbsencesCount = _absencesRepo.absencesCount;

    final currentPage = _absencesRepo.absences;
    final members = _absencesRepo.members;

    _emit(
      currentPage: currentPage,
      members: members,
      absencesCount: totalAbsencesCount,
    );
  }

  Future<void> moveToNextPage() async {
    _emit(
      execution: Executing(),
      paginationIndex: _state.value.paginationIndex + 1,
    );

    final result = await _absencesRepo.getMoreAbsences(
      type: _state.value.typeFilter,
      status: _state.value.statusFilter,
      startDate: _state.value.startDateFilter,
      endDate: _state.value.endDateFilter,
      memberId: _state.value.memberIdFilter,
      crewId: _state.value.crewIdFilter,
    );

    result.when(
      success: (_) {
        final currentPage = _absencesRepo.absences.sublist(
          _state.value.paginationIndex * Statics.paginationLimit,
          ((_state.value.paginationIndex + 1) * Statics.paginationLimit).clamp(
            0,
            _absencesRepo.absences.length,
          ),
        );

        _emit(currentPage: currentPage, execution: Succeeded());
      },
      failure: (error) {
        _emit(execution: Failed(error));
      },
    );
  }

  Future<void> moveToPreviousPage() async {
    if (_state.value.paginationIndex == 0) {
      return;
    }
    
    _emit(execution: Executing());

    final index = (_state.value.paginationIndex - 1).clamp(
      0,
      _state.value.paginationIndex - 1,
    );

    final currentPage = _absencesRepo.absences.sublist(
      index * Statics.paginationLimit,
      (index + 1) * Statics.paginationLimit,
    );

    _emit(
      currentPage: currentPage,
      paginationIndex: index,
      execution: Succeeded(),
    );
  }

  Member? getMemberById(int? id) {
    return _state.value.members.firstWhere(
      (member) => member?.userId == id,
      orElse: () => null,
    );
  }

  Future<void> filterAbsences({
    AbsenceType? type,
    AbsenceStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int? memberId,
    int? crewId,
  }) async {
    _emit(
      execution: Executing(),
      paginationIndex: 0,
      typeFilter: type,
      statusFilter: status,
      startDateFilter: startDate,
      endDateFilter: endDate,
      memberIdFilter: memberId,
      crewIdFilter: crewId,
    );

    final result = await _absencesRepo.getMoreAbsences(
      type: type,
      status: status,
      startDate: startDate,
      endDate: endDate,
      memberId: memberId,
      crewId: crewId,
      isRefresh: true,
    );

    result.when(
      success: (absences) {
        final currentPage = _absencesRepo.absences.sublist(
          _state.value.paginationIndex * Statics.paginationLimit,
          ((_state.value.paginationIndex + 1) * Statics.paginationLimit).clamp(
            0,
            _absencesRepo.absences.length,
          ),
        );

        _emit(
          currentPage: currentPage,
          absencesCount: _absencesRepo.absencesCount,
          execution: Succeeded(),
        );
      },
      failure: (error) {
        _emit(execution: Failed(error));
      },
    );
  }

  Future<void> clearFilters() async {
    _emit(
      typeFilter: AbsenceType.none,
      statusFilter: AbsenceStatus.none,
      memberIdFilter: -1,
      crewIdFilter: -1,
      clearEndDate: true,
      clearStartDate: true,
    );
  }

  Future<void> logout() async {
    _absencesRepo.clear();
    final result = await _userRepo.logout();

    if (result) {
      _output.goToLogin();
    }
  }

  Absence? getAbsenceById(int? id) {
    return _state.value.currentPage.firstWhere(
      (absence) => absence?.id == id,
      orElse: () => null,
    );
  }

  void _emit({
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
  }) =>
      _state.value = _state.value.copyWith(
        execution: execution,
        currentPage: currentPage,
        members: members,
        absencesCount: absencesCount,
        paginationIndex: paginationIndex,
        typeFilter: typeFilter,
        statusFilter: statusFilter,
        startDateFilter: startDateFilter,
        endDateFilter: endDateFilter,
        memberIdFilter: memberIdFilter,
        crewIdFilter: crewIdFilter,
        clearStartDate: clearStartDate,
        clearEndDate: clearEndDate,
      );

  @override
  void clear() {
    _state.value = const AbsencesState();
  }
}
