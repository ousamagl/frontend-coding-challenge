import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';

import '../mocks/outputs.mocks.dart';
import '../mocks/repositories.mocks.dart';

void main() {
  final arranger = _Arranger();

  AbsencesViewModel createViewModel({AbsencesState? initialState}) =>
      AbsencesViewModel(
        arranger._output,
        arranger._absencesRepo,
        arranger._userRepo,
        initialState: initialState,
      );

  setUp(arranger.resetMocks);

  test('it should initialize with the correct state', () {
    final viewModel = createViewModel();

    final state = viewModel.state.value;

    expect(state, equals(const AbsencesState()));
  });

  test(
    'it should load absences if necessary when initializing',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel();

      when(arranger._absencesRepo.absences).thenReturn([]);
      when(arranger._absencesRepo.init()).thenAnswer((_) async {});
      when(arranger._absencesRepo.absencesCount).thenReturn(0);
      when(arranger._absencesRepo.members).thenReturn([]);

      viewModel.init();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      verify(arranger._absencesRepo.init()).called(1);

      expect(state.execution, Succeeded());
    }),
  );

  test(
    'it should not load absences if they are already loaded',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel();

      when(arranger._absencesRepo.absences).thenReturn([_dummyAbsence1]);
      when(arranger._absencesRepo.init()).thenAnswer((_) async {});
      when(arranger._absencesRepo.absencesCount).thenReturn(1);
      when(arranger._absencesRepo.members).thenReturn([]);

      viewModel.init();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      verifyNever(arranger._absencesRepo.init());

      expect(state.execution, Idle());
      expect(state.absencesCount, 1);
    }),
  );

  test(
    'it should move to the next page and load more absences',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel(
        initialState: AbsencesState(execution: Executing()),
      );

      when(arranger._absencesRepo.absences).thenReturn([
        ...List.generate(10, (_) => _dummyAbsence1),
        ...List.generate(10, (_) => _dummyAbsence2),
      ]);

      when(
        arranger._absencesRepo.getMoreAbsences(
          type: anyNamed('type'),
          status: anyNamed('status'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          memberId: anyNamed('memberId'),
          crewId: anyNamed('crewId'),
        ),
      ).thenAnswer((_) async => Success([]));

      viewModel.moveToNextPage();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      expect(state.execution, Succeeded());
      expect(state.paginationIndex, 1);
      expect(state.currentPage, List.generate(10, (_) => _dummyAbsence2));
    }),
  );

  test(
    'it should handle errors when loading more absences',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel(
        initialState: AbsencesState(execution: Executing()),
      );

      when(arranger._absencesRepo.absences).thenReturn([_dummyAbsence1]);

      when(
        arranger._absencesRepo.getMoreAbsences(
          type: anyNamed('type'),
          status: anyNamed('status'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          memberId: anyNamed('memberId'),
          crewId: anyNamed('crewId'),
        ),
      ).thenAnswer((_) async => Failure(Exception()));

      viewModel.moveToNextPage();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      expect(state.execution, Failed());
    }),
  );

  test(
    'it should move to the previous page and load absences',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel(
        initialState: AbsencesState(execution: Executing(), paginationIndex: 1),
      );

      when(arranger._absencesRepo.absences).thenReturn([
        ...List.generate(10, (_) => _dummyAbsence1),
        ...List.generate(10, (_) => _dummyAbsence2),
      ]);

      viewModel.moveToPreviousPage();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      expect(state.execution, Succeeded());
      expect(state.paginationIndex, 0);
      expect(state.currentPage, List.generate(10, (_) => _dummyAbsence1));
    }),
  );

  test(
    'it should exit if pagination index is zero when moving to the previous page',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel(
        initialState: AbsencesState(execution: Idle()),
      );

      when(arranger._absencesRepo.absences).thenReturn([
        ...List.generate(10, (_) => _dummyAbsence1),
        ...List.generate(10, (_) => _dummyAbsence2),
      ]);

      viewModel.moveToPreviousPage();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      expect(state.execution, Idle());
    }),
  );

  test(
    'it should set the correct filters and reload absences',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel();

      when(arranger._absencesRepo.absences).thenReturn([_dummyAbsence1]);

      when(
        arranger._absencesRepo.getMoreAbsences(
          type: anyNamed('type'),
          status: anyNamed('status'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          memberId: anyNamed('memberId'),
          crewId: anyNamed('crewId'),
          isRefresh: true,
        ),
      ).thenAnswer((_) async => Success([]));

      when(arranger._absencesRepo.absencesCount).thenReturn(1);
      when(arranger._absencesRepo.members).thenReturn([]);

      viewModel.filterAbsences(
        type: AbsenceType.sickness,
        status: AbsenceStatus.confirmed,
        startDate: DateTime(2025),
        endDate: DateTime(2025),
        memberId: 1,
        crewId: 2,
      );

      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      expect(state.execution, Succeeded());
      expect(state.typeFilter, AbsenceType.sickness);
      expect(state.statusFilter, AbsenceStatus.confirmed);
      expect(state.startDateFilter, DateTime(2025));
      expect(state.endDateFilter, DateTime(2025));
      expect(state.memberIdFilter, 1);
      expect(state.crewIdFilter, 2);

      verify(
        arranger._absencesRepo.getMoreAbsences(
          type: AbsenceType.sickness,
          status: AbsenceStatus.confirmed,
          startDate: DateTime(2025),
          endDate: DateTime(2025),
          memberId: 1,
          crewId: 2,
          isRefresh: true,
        ),
      ).called(1);
    }),
  );

  test(
    'it should clear filters and NOT reload absences',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel(
        initialState: AbsencesState(
          typeFilter: AbsenceType.sickness,
          statusFilter: AbsenceStatus.confirmed,
          startDateFilter: DateTime(2025),
          endDateFilter: DateTime(2025),
          memberIdFilter: 1,
          crewIdFilter: 2,
        ),
      );

      when(arranger._absencesRepo.absences).thenReturn([_dummyAbsence1]);

      when(
        arranger._absencesRepo.getMoreAbsences(
          type: anyNamed('type'),
          status: anyNamed('status'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
          memberId: anyNamed('memberId'),
          crewId: anyNamed('crewId'),
        ),
      ).thenAnswer((_) async => Success([]));

      when(arranger._absencesRepo.absencesCount).thenReturn(1);
      when(arranger._absencesRepo.members).thenReturn([]);

      viewModel.clearFilters();
      fakeAsync.elapse(const Duration(microseconds: 1));

      final state = viewModel.state.value;

      expect(state.typeFilter, AbsenceType.none);
      expect(state.statusFilter, AbsenceStatus.none);
      expect(state.startDateFilter, null);
      expect(state.endDateFilter, null);
      expect(state.memberIdFilter, -1);
      expect(state.crewIdFilter, -1);

      verifyNever(
        arranger._absencesRepo.getMoreAbsences(
          type: AbsenceType.none,
          status: AbsenceStatus.none,
          memberId: -1,
          crewId: -1,
        ),
      );
    }),
  );

  test(
    'it should clear absences repo and navigate to login when logging out',
    () => FakeAsync().run((fakeAsync) {
      final viewModel = createViewModel();

      when(arranger._absencesRepo.clear()).thenAnswer((_) async {});
      when(arranger._userRepo.logout()).thenAnswer((_) async => true);

      viewModel.logout();

      fakeAsync.elapse(const Duration(microseconds: 1));

      verify(arranger._absencesRepo.clear()).called(1);
      verify(arranger._userRepo.logout()).called(1);
      verify(arranger._output.goToLogin()).called(1);
    }),
  );
}

class _Arranger {
  _Arranger() {
    _absencesRepo = MockAbsencesRepo();
    _userRepo = MockUserRepo();
    _output = MockAbsencesOutput();
  }

  late final MockAbsencesRepo _absencesRepo;
  late final MockUserRepo _userRepo;
  late final MockAbsencesOutput _output;

  void resetMocks() {
    reset(_absencesRepo);
    reset(_userRepo);
    reset(_output);
  }
}

final _dummyAbsence1 = Absence(
  id: 1,
  userId: 11,
  admitterId: 12,
  crewId: 123,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(days: 1)),
);

final _dummyAbsence2 = Absence(
  id: 2,
  userId: 21,
  admitterId: 22,
  crewId: 223,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(days: 2)),
);
