import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sickness_manager/app/core/common/statics.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/core/repositories/absences_repo.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';

import '../mocks/data_sources.mocks.mocks.dart';

void main() {
  final arranger = _Arranger();

  AbsencesRepo createRepo() =>
      AbsencesRepoImpl(absencesDataSource: arranger._absencesDataSource);

  setUp(arranger.resetMocks);

  test('it should initialize with the correct values', () {
    final repo = createRepo();

    expect(repo.absences, []);
    expect(repo.members, []);
    expect(repo.absencesCount, 0);
  });

  test(
    'it should load absences and members from data source when initializing',
    () => FakeAsync().run((fakeAsync) {
      final repo = createRepo();

      when(
        arranger._absencesDataSource.getMembers(),
      ).thenAnswer((_) async => Success([_dummyMember]));

      when(
        arranger._absencesDataSource.getAbsences(
          limit: Statics.paginationLimit,
        ),
      ).thenAnswer((_) async => Success([_dummyAbsence1]));

      repo.init();

      fakeAsync.flushMicrotasks();

      expect(repo.absences, [_dummyAbsence1]);
      expect(repo.members, [_dummyMember]);

      verify(arranger._absencesDataSource.getMembers()).called(1);
      verify(
        arranger._absencesDataSource.getAbsences(
          limit: Statics.paginationLimit,
        ),
      ).called(1);
    }),
  );

  test(
    'it should return absences count from data source',
    () => FakeAsync().run((fakeAsync) {
      final repo = createRepo();

      when(
        arranger._absencesDataSource.getAbsencesCount(),
      ).thenAnswer((_) async => 5);

      repo.getAbsencesCount();

      fakeAsync.flushMicrotasks();

      expect(repo.absencesCount, 5);

      verify(arranger._absencesDataSource.getAbsencesCount()).called(1);
    }),
  );

  test(
    'it should paginate absences by increasing offset',
    () => FakeAsync().run((fakeAsync) {
      final repo = createRepo();

      when(
        arranger._absencesDataSource.getAbsences(
          offset: anyNamed('offset'),
          limit: Statics.paginationLimit,
        ),
      ).thenAnswer((_) async => Success([_dummyAbsence1]));

      repo.getMoreAbsences();

      fakeAsync.flushMicrotasks();

      expect(repo.absences, [_dummyAbsence1]);

      verify(
        arranger._absencesDataSource.getAbsences(
          offset: Statics.paginationLimit,
          limit: Statics.paginationLimit,
        ),
      ).called(1);
    }),
  );

  test(
    'it should reset pagination when loading more absences with refresh enabled ',
    () => FakeAsync().run((fakeAsync) {
      final repo = createRepo();

      when(
        arranger._absencesDataSource.getAbsences(
          offset: anyNamed('offset'),
          limit: Statics.paginationLimit,
        ),
      ).thenAnswer((_) async => Success([_dummyAbsence1]));

      repo.getMoreAbsences();

      verify(
        arranger._absencesDataSource.getAbsences(
          offset: Statics.paginationLimit,
          limit: Statics.paginationLimit,
        ),
      ).called(1);

      repo.getMoreAbsences();

      verify(
        arranger._absencesDataSource.getAbsences(
          offset: 2 * Statics.paginationLimit,
          limit: Statics.paginationLimit,
        ),
      );

      repo.getMoreAbsences(isRefresh: true);

      fakeAsync.flushMicrotasks();

      expect(repo.absences, [_dummyAbsence1]);

      verify(
        arranger._absencesDataSource.getAbsences(
          // ignore: avoid_redundant_argument_values
          offset: 0,
          limit: Statics.paginationLimit,
        ),
      ).called(1);
    }),
  );
}

class _Arranger {
  _Arranger() {
    _absencesDataSource = MockAbsencesDataSource();
  }

  late final MockAbsencesDataSource _absencesDataSource;

  void resetMocks() {
    reset(_absencesDataSource);
  }
}

final _dummyAbsence1 = Absence(
  id: 1,
  userId: 11,
  admitterId: 12,
  crewId: 123,
  startDate: DateTime(2025),
  endDate: DateTime(2025),
);

final _dummyMember = Member(
  crewId: 1,
  id: 1,
  image: 'image',
  name: 'name',
  userId: 22,
);
