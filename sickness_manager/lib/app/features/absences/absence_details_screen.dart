import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';

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
          appBar: AppBar(title: const Text('Absence Details')),
          body: Center(child: Text('Absence Details Screen')),
        );
      },
    );
  }
}
