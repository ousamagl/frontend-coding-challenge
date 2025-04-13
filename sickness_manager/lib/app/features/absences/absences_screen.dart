import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';

class AbsencesScreen extends StatefulWidget {
  const AbsencesScreen({required this.viewModel, super.key});

  final AbsencesViewModel viewModel;

  @override
  State<AbsencesScreen> createState() => _AbsencesScreenState();
}

class _AbsencesScreenState extends State<AbsencesScreen> {
  AbsencesViewModel get _viewModel => widget.viewModel;

  AbsencesState get _state => _viewModel.state.value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AbsencesState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () => context.pushNamed('absence-filters'),
              child: const Text('Absences'),
            ),
          ),
          body: Center(child: Text('Absences Screen')),
        );
      },
    );
  }
}
