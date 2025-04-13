import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';

class AbsencesFilterScreen extends StatefulWidget {
  const AbsencesFilterScreen({required this.viewModel, super.key});

  final AbsencesViewModel viewModel;

  @override
  State<AbsencesFilterScreen> createState() => _AbsencesFilterScreenState();
}

class _AbsencesFilterScreenState extends State<AbsencesFilterScreen> {
  AbsencesViewModel get _viewModel => widget.viewModel;

  AbsencesState get _state => _viewModel.state.value;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AbsencesState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Absence filter')),
          body: Center(child: Text('Absence Filter Screen')),
        );
      },
    );
  }
}
