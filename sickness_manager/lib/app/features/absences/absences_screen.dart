import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/extensions/date_time_extensions.dart';
import 'package:sickness_manager/app/core/common/extensions/string_extensions.dart';
import 'package:sickness_manager/app/core/common/statics.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
import 'package:sickness_manager/app/features/absences/widgets/absence_status_widget.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

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
        return ColoredBox(
          color: AppColors.primary,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: AppColors.secondary,
              body:
                  _state.execution.isFailed
                      ? _errorWidget()
                      : CustomScrollView(
                        slivers: [_appBar(), ..._absencesList()],
                      ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: _bottomBar(),
            ),
          ),
        );
      },
    );
  }

  Widget _appBar() => SliverAppBar(
    title: Text(
      'Absences',
      style: TextStyles.header.copyWith(color: AppColors.white),
    ),
    centerTitle: false,
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    actions: [
      IconButton(
        icon: Stack(
          children: [
            const FaIcon(FontAwesomeIcons.filter, color: AppColors.white),
            if (_state.memberIdFilter != -1 ||
                _state.crewIdFilter != -1 ||
                _state.startDateFilter != null ||
                _state.endDateFilter != null ||
                _state.typeFilter != AbsenceType.none ||
                _state.statusFilter != AbsenceStatus.none)
              Positioned(
                right: 0,
                child: CircleAvatar(radius: 5, backgroundColor: AppColors.red),
              ),
          ],
        ),
        onPressed: () => context.pushNamed('absence-filters'),
      ),
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.userSlash, color: AppColors.white),
        onPressed: () => _viewModel.logout(),
      ),
    ],
    floating: true,
  );

  List<Widget> _absencesList() => [
    SliverToBoxAdapter(child: smSpacer()),
    _state.currentPage.isEmpty
        ? SliverToBoxAdapter(child: _emptyWidget())
        : SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                _state.execution.isExecuting
                    ? cardLoader()
                    : _absenceItem(_state.currentPage[index]),
            childCount:
                _state.execution.isExecuting ? 10 : _state.currentPage.length,
          ),
        ),
    SliverToBoxAdapter(child: xxxlSpacer()),
  ];

  Widget _absenceItem(Absence? absence) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Dimensions.sm,
      vertical: Dimensions.xxs,
    ),
    child: ListTile(
      key: ValueKey(absence?.id),
      leading: _absenceTypeIndicator(absence),
      title: Text(
        _viewModel.getMemberById(absence?.userId)?.name ?? 'Unknown',
        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: _absenceItemDetails(absence),
      trailing: _absenceItemStatus(absence),
      tileColor: AppColors.white,
      minLeadingWidth: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.xs),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Dimensions.sm,
        vertical: Dimensions.xxs,
      ),
      onTap: () {
        context.pushNamed(
          'absence-details',
          pathParameters: {'id': absence?.id.toString() ?? ''},
        );
      },
    ),
  );

  Widget _absenceTypeIndicator(Absence? absence) => Container(
    width: 3,
    decoration: BoxDecoration(
      color:
          absence?.absenceType == AbsenceType.sickness
              ? AppColors.yellow
              : AppColors.green,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
  );

  Widget _absenceItemDetails(Absence? absence) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      xxsSpacer(),
      Row(
        children: [
          Icon(
            FontAwesomeIcons.calendar,
            size: Dimensions.sm,
            color: AppColors.darkGrey,
          ),
          xsSpacer(),
          Text(
            '${absence?.startDate.toDayMonthYear()} - ${absence?.endDate.toDayMonthYear()}',
            style: TextStyles.caption.copyWith(color: AppColors.darkGrey),
          ),
        ],
      ),
      xxsSpacer(),
      Text('Type: ${absence?.type?.capitalizeFirstLetter() ?? 'Unknown'}'),
    ],
  );

  Widget _absenceItemStatus(Absence? absence) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AbsenceStatusWidget(status: absence?.status),
        xsSpacer(),
        Icon(
          FontAwesomeIcons.chevronRight,
          size: Dimensions.sm,
          color: AppColors.darkGrey,
        ),
      ],
    );
  }

  Widget _bottomBar() => Padding(
    padding: Paddings.horizontalSm,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.sm,
        vertical: Dimensions.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Dimensions.xs),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Absences: ${_state.absencesCount}',
            style: TextStyles.body.copyWith(color: AppColors.white),
          ),
          _paginationControls(),
        ],
      ),
    ),
  );

  Widget _paginationControls() => Row(
    children: [
      InkWell(
        child: Icon(
          FontAwesomeIcons.chevronLeft,
          size: Dimensions.sm,
          color:
              _state.paginationIndex == 0
                  ? AppColors.lightGrey
                  : AppColors.white,
        ),
        onTap: () {
          if (_state.paginationIndex > 0) {
            _viewModel.moveToPreviousPage();
          }
        },

        onDoubleTap: () {},
      ),
      lgSpacer(),
      InkWell(
        child: Icon(
          FontAwesomeIcons.chevronRight,
          size: Dimensions.sm,
          color:
              (_state.paginationIndex * Statics.paginationLimit >=
                          _state.absencesCount ||
                      _state.currentPage.length < Statics.paginationLimit)
                  ? AppColors.lightGrey
                  : AppColors.white,
        ),
        onTap: () {
          if (!(_state.paginationIndex * Statics.paginationLimit >=
                  _state.absencesCount ||
              _state.currentPage.length < Statics.paginationLimit)) {
            _viewModel.moveToNextPage();
          }
        },

        onDoubleTap: () {},
      ),
    ],
  );

  Widget _errorWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.triangleExclamation,
          size: Dimensions.xl,
          color: AppColors.orange,
        ),
        xsSpacer(),
        Text('Something Went Wrong', style: TextStyles.body),
      ],
    ),
  );

  Widget _emptyWidget() => SizedBox(
    height: MediaQuery.of(context).size.height * 0.7,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: Dimensions.xl,
          color: AppColors.orange,
        ),
        xsSpacer(),
        Text('No Absences Found', style: TextStyles.body),
      ],
    ),
  );
}
