import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class AbsencesFilterScreen extends StatefulWidget {
  const AbsencesFilterScreen({required this.viewModel, super.key});

  final AbsencesViewModel viewModel;

  @override
  State<AbsencesFilterScreen> createState() => _AbsencesFilterScreenState();
}

class _AbsencesFilterScreenState extends State<AbsencesFilterScreen> {
  AbsencesViewModel get _viewModel => widget.viewModel;

  AbsencesState get _state => _viewModel.state.value;

  String? _selectedType;
  String? _selectedStatus;
  String? _selectedMemberName;
  int? _selectedCrewId;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    initFiltersFromState();
  }

  void initFiltersFromState() {
    _selectedType =
        _state.typeFilter == AbsenceType.none
            ? null
            : _state.typeFilter.displayName;

    _selectedStatus =
        _state.statusFilter == AbsenceStatus.none
            ? null
            : _state.statusFilter.displayName;
    _selectedMemberName =
        _state.memberIdFilter == -1
            ? null
            : _state.members
                .firstWhere(
                  (member) => member?.userId == _state.memberIdFilter,
                  orElse: () => null,
                )
                ?.name;

    _selectedCrewId =
        _state.crewIdFilter == -1
            ? null
            : _state.members
                .firstWhere((member) => member?.crewId == _state.crewIdFilter)
                ?.crewId;

    _startDate = _state.startDateFilter;
    _endDate = _state.endDateFilter;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AbsencesState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return Scaffold(
          appBar: _appBar(),
          body: Padding(
            padding: Paddings.allSm,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _typeFilter(),
                  smSpacer(),
                  _statusFilter(),
                  smSpacer(),
                  _memberFilter(),
                  smSpacer(),
                  _crewFilter(),
                  smSpacer(),
                  _startDateFilter(),
                  smSpacer(),
                  _endDateFilter(),
                  lgSpacer(),
                  _buttonsRow(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() => AppBar(
    title: Text(
      'Filters',
      style: TextStyles.header.copyWith(color: AppColors.white),
    ),
    centerTitle: false,
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    foregroundColor: AppColors.white,
    titleSpacing: Dimensions.xs,
    actions: [
      IconButton(
        key: const Key('logoutButton'),
        icon: const FaIcon(FontAwesomeIcons.userSlash, color: AppColors.white),
        onPressed: () => _viewModel.logout(),
      ),
    ],
  );

  Widget _typeFilter() => choicePicker(
    label: 'Absence Type',
    icon: FontAwesomeIcons.umbrellaBeach,
    options:
        AbsenceType.values.skip(1).map((type) => type.displayName).toList(),
    selectedValue: _selectedType,
    onChanged: (value) {
      setState(() {
        _selectedType = value;
      });
    },
  );

  Widget _statusFilter() => choicePicker(
    label: 'Absence Status',
    icon: FontAwesomeIcons.fileCircleQuestion,
    options:
        AbsenceStatus.values
            .skip(1)
            .map((status) => status.displayName)
            .toList(),
    selectedValue: _selectedStatus,
    onChanged: (value) {
      setState(() {
        _selectedStatus = value;
      });
    },
  );

  Widget _memberFilter() => dropDownPicker<String>(
    label: 'Member',
    icon: FontAwesomeIcons.solidUser,
    value: _selectedMemberName,
    items: _state.members.map((member) => member?.name ?? 'Unknown').toList(),
    onChanged: (value) {
      setState(() {
        _selectedMemberName = value;
      });
    },
  );

  Widget _crewFilter() => dropDownPicker<int>(
    label: 'Crew',
    icon: FontAwesomeIcons.users,
    value: _selectedCrewId,
    items:
        _state.members.map((member) => member?.crewId ?? -1).toSet().toList(),
    onChanged: (value) {
      setState(() {
        _selectedCrewId = value;
      });
    },
  );

  Widget _startDateFilter() => datePicker(
    context,
    label: 'Start Date',
    icon: FontAwesomeIcons.calendarCheck,
    selectedDate: _startDate,
    onDateSelected: (DateTime date) {
      setState(() {
        _startDate = date;
      });
    },
  );

  Widget _endDateFilter() => datePicker(
    context,
    label: 'End Date',
    icon: FontAwesomeIcons.calendarXmark,
    selectedDate: _endDate,
    onDateSelected: (DateTime date) {
      setState(() {
        _endDate = date;
      });
    },
  );

  Widget _buttonsRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [
      Flexible(
        child: primaryFilledButton(
          'Apply',
          onPressed: () => _applyFilters(),
          color: AppColors.primary,
          textColor: AppColors.white,
        ),
      ),
      xsSpacer(),
      Flexible(
        child: primaryOutlinedButton(
          'Clear Filters',
          onPressed: () {
            setState(() {
              _selectedType = null;
              _selectedStatus = null;
              _selectedMemberName = null;
              _selectedCrewId = null;
              _startDate = null;
              _endDate = null;
            });

            _viewModel.clearFilters();
          },
          color: AppColors.primary,
          textColor: AppColors.primary,
        ),
      ),
    ],
  );

  void _applyFilters() {
    final type = AbsenceType.fromString(_selectedType ?? '');
    final status = AbsenceStatus.fromString(_selectedStatus ?? '');
    final memberId =
        _state.members
            .firstWhere(
              (member) => member?.name == _selectedMemberName,
              orElse: () => null,
            )
            ?.userId;
    final crewId = _selectedCrewId;

    _viewModel.filterAbsences(
      type: type,
      status: status,
      startDate: _startDate,
      endDate: _endDate,
      memberId: memberId,
      crewId: crewId,
    );

    context.pop();
  }
}
