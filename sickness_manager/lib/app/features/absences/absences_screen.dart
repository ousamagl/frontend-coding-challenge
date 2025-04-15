import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sickness_manager/app/core/common/extensions/date_time_extensions.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
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
              body: CustomScrollView(
                slivers: [
                  _appBar(),
                  SliverToBoxAdapter(child: smSpacer()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _absenceItem(state.absences[index]),
                      childCount: state.absences.length,
                    ),
                  ),
                  SliverToBoxAdapter(child: xxxlSpacer()),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: _totalAbsences(),
            ),
          ),
        );
      },
    );
  }

  Widget _appBar() => SliverAppBar(
    title: Text(
      'Absences',
      style: TextStyles.subtitle.copyWith(color: AppColors.white),
    ),
    centerTitle: false,
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    actions: [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.filter, color: AppColors.white),
        onPressed: () => context.pushNamed('absence-filters'),
      ),
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.userGear, color: AppColors.white),
        onPressed: () => _viewModel.logout(),
      ),
    ],
    floating: true,
  );

  Widget _totalAbsences() => Padding(
    padding: Paddings.horizontalSm,
    child: Container(
      width: double.infinity,
      padding: Paddings.allXs,
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
      child: Text(
        'Total Absences: ${_state.absences.length}',
        style: TextStyles.body.copyWith(color: AppColors.white),
      ),
    ),
  );

  Widget _absenceItem(Absence absence) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Dimensions.sm,
      vertical: Dimensions.xxs,
    ),
    child: ListTile(
      leading: Container(
        width: 3,
        decoration: BoxDecoration(color: AppColors.orange),
      ),
      title: Text(
        'Member name',
        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: _absenceItemSubtitle(absence),
      trailing: _absenceItemTrailing(absence),
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
          pathParameters: {'id': absence.id.toString()},
        );
      },
    ),
  );

  Widget _absenceItemSubtitle(Absence absence) => Column(
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
            '${absence.startDate.toDayMonth()} - ${absence.endDate.toDayMonth()}',
            style: TextStyles.caption.copyWith(color: AppColors.darkGrey),
          ),
        ],
      ),

      xxsSpacer(),
      Text('Type: ${absence.type ?? 'Unknown'}'),
    ],
  );

  Widget _absenceItemTrailing(Absence absence) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.sm,
          vertical: Dimensions.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.orange.withAlpha(50),
          borderRadius: BorderRadius.circular(Dimensions.md),
          border: Border.all(color: AppColors.orange),
        ),
        child: Text(
          'Requested',
          style: TextStyles.footnote.copyWith(color: AppColors.orange),
        ),
      ),
      xsSpacer(),
      Icon(
        FontAwesomeIcons.chevronRight,
        size: Dimensions.sm,
        color: AppColors.darkGrey,
      ),
    ],
  );
}
