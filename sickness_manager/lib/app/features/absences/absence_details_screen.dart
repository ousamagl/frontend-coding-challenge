import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class AbsenceDetailsScreen extends StatefulWidget {
  const AbsenceDetailsScreen({required this.viewModel, super.key});

  final AbsencesViewModel viewModel;

  @override
  State<AbsenceDetailsScreen> createState() => _AbsenceDetailsScreenState();
}

class _AbsenceDetailsScreenState extends State<AbsenceDetailsScreen> {
  AbsencesViewModel get _viewModel => widget.viewModel;

  AbsencesState get _state => _viewModel.state.value;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AbsencesState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: _appBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Absence ID: ${state.absences.first.id}'),
                const SizedBox(height: 8),
                Text('User ID: ${state.absences.first.userId}'),
                const SizedBox(height: 8),
                Text('Crew ID: ${state.absences.first.crewId}'),
                const SizedBox(height: 8),
                Text('Start Date: ${state.absences.first.startDate}'),
                const SizedBox(height: 8),
                Text('End Date: ${state.absences.first.endDate}'),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() => AppBar(
    title: Text(
      'Vacation',
      style: TextStyles.subtitle.copyWith(color: AppColors.white),
    ),
    centerTitle: false,
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    foregroundColor: AppColors.white,
    titleSpacing: Dimensions.xs,
    actions: [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.userGear, color: AppColors.white),
        onPressed: () {},
      ),
    ],
  );
}
