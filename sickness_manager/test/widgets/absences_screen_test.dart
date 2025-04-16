import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sickness_manager/app/core/common/types/execution.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/features/absences/absences_screen.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';

import '../mocks/view_models.mocks.dart';

void main() {
  group('AbsencesScreen', () {
    late MockAbsencesViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockAbsencesViewModel();
    });

    testWidgets('it should show loading state when fetching absences', (
      tester,
    ) async {
      when(mockViewModel.state).thenReturn(
        ValueNotifier(
          AbsencesState(execution: Executing(), currentPage: [_dummyAbsence1]),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(home: AbsencesScreen(viewModel: mockViewModel)),
      );

      expect(find.byKey(Key('cardLoader')), findsAny);
    });

    testWidgets('it should show error widget when execution fails', (
      tester,
    ) async {
      when(mockViewModel.state).thenReturn(
        ValueNotifier(AbsencesState(execution: Failed(), currentPage: [])),
      );

      await tester.pumpWidget(
        MaterialApp(home: AbsencesScreen(viewModel: mockViewModel)),
      );

      expect(find.text('Something Went Wrong'), findsOneWidget);
    });

    testWidgets('it should show empty widget when no absences are found', (
      tester,
    ) async {
      when(mockViewModel.state).thenReturn(
        ValueNotifier(AbsencesState(execution: Idle(), currentPage: [])),
      );

      await tester.pumpWidget(
        MaterialApp(home: AbsencesScreen(viewModel: mockViewModel)),
      );

      expect(find.text('No Absences Found'), findsOneWidget);
    });

    testWidgets('it should show absence items when absences are available', (
      tester,
    ) async {
      final absences = [
        Absence(
          id: 1,
          userId: 1,
          crewId: 1,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: 1)),
        ),
      ];

      when(mockViewModel.state).thenReturn(
        ValueNotifier(
          AbsencesState(
            execution: Idle(),
            currentPage: absences,
            absencesCount: 1,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(home: AbsencesScreen(viewModel: mockViewModel)),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });
  });
}

final _dummyAbsence1 = Absence(
  id: 1,
  userId: 11,
  admitterId: 12,
  crewId: 123,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(days: 1)),
);
