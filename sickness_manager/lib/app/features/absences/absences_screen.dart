import 'package:flutter/material.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';

class AbsencesScreen extends StatefulWidget {
  const AbsencesScreen({super.key, required this.viewModel});

  final AbsencesViewModel viewModel;

  @override
  State<AbsencesScreen> createState() => _AbsencesScreenState();
}

class _AbsencesScreenState extends State<AbsencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absences')),
      body: Center(child: Text('Absences Screen')),
    );
  }
}
