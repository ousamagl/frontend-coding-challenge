import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/extensions/absence_extension.dart';
import 'package:sickness_manager/app/core/common/extensions/date_time_extensions.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_state.dart';
import 'package:sickness_manager/app/features/absences/view_model/absences_view_model.dart';
import 'package:sickness_manager/app/features/absences/widgets/absence_status_widget.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class AbsenceDetailsScreen extends StatefulWidget {
  const AbsenceDetailsScreen({
    required this.viewModel,
    this.absenceId,
    super.key,
  });

  final AbsencesViewModel viewModel;
  final int? absenceId;

  @override
  State<AbsenceDetailsScreen> createState() => _AbsenceDetailsScreenState();
}

class _AbsenceDetailsScreenState extends State<AbsenceDetailsScreen> {
  AbsencesViewModel get _viewModel => widget.viewModel;

  late final Absence? _absence;
  late final Member? _member;

  @override
  void initState() {
    super.initState();

    _absence = _viewModel.getAbsenceById(widget.absenceId);
    _member = _viewModel.getMemberById(_absence?.userId);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AbsencesState>(
      valueListenable: _viewModel.state,
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: _appBar(),
          body: Padding(
            padding: Paddings.allSm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _overviewWidget(),
                smSpacer(),
                _absenceStatusWidget(),
                smSpacer(),
                ..._notesList(),
                Spacer(),
                Padding(
                  padding: Paddings.allSm,
                  child: primaryFilledButton(
                    'Export As iCal',
                    onPressed: () => _absence?.shareICallFile(),
                  ),
                ),
                smSpacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() => AppBar(
    title: Text(
      'Absence Details',
      style: TextStyles.header.copyWith(color: AppColors.white),
    ),
    centerTitle: false,
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    foregroundColor: AppColors.white,
    titleSpacing: Dimensions.xs,
    actions: [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.userSlash, color: AppColors.white),
        onPressed: () => _viewModel.logout(),
      ),
    ],
  );

  Widget _overviewWidget() => Container(
    padding: Paddings.allXs,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
    child: Row(
      children: [
        ..._userDetails(),

        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_dateWidget(), xsSpacer(), _absenceTypeWidget()],
        ),
      ],
    ),
  );

  Widget _absenceStatusWidget() => Container(
    padding: Paddings.allSm,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
    child: Row(
      children: [
        Column(
          children: [
            AbsenceStatusWidget(status: AbsenceStatus.requested),
            xsSpacer(),
            _timeStampWidget(_absence?.createdAt),
          ],
        ),
        ..._arrowSeparator(),
        if (_absence?.status == AbsenceStatus.requested) ...[
          Icon(
            FontAwesomeIcons.circleQuestion,
            size: Dimensions.lg,
            color: AppColors.darkGrey.withValues(alpha: 0.2),
          ),
          smSpacer(),
        ],
        if (_absence?.status != AbsenceStatus.requested)
          Column(
            children: [
              AbsenceStatusWidget(status: _absence?.status),
              xsSpacer(),

              _timeStampWidget(
                _absence?.status == AbsenceStatus.confirmed
                    ? _absence?.confirmedAt
                    : _absence?.rejectedAt,
              ),
            ],
          ),
      ],
    ),
  );

  List<Widget> _notesList() => [
    if (_absence?.memberNote != null && _absence!.memberNote!.isNotEmpty) ...[
      Divider(color: AppColors.darkGrey.withValues(alpha: 0.1), thickness: 1),
      xsSpacer(),
      _noteWidget(
        note: _absence.memberNote!,

        avatarUrl: _member?.image ?? '',
        isMember: true,
      ),
    ],
    if (_absence?.admitterNote != null &&
        _absence!.admitterNote!.isNotEmpty) ...[
      smSpacer(),

      Align(
        alignment: Alignment.centerRight,
        child: _noteWidget(note: _absence.admitterNote!),
      ),
    ],
  ];

  Widget _noteWidget({
    required String note,
    String? avatarUrl,
    bool isMember = false,
  }) => Container(
    padding: Paddings.allXs,
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * 0.7,
    ),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        if (avatarUrl != null) _avatarWidget(avatarUrl, isCompact: true),

        smSpacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMember ? 'Member Note' : 'Admitter Note',

                style: TextStyles.footnote.copyWith(color: AppColors.darkGrey),
              ),
              Text(
                note,
                style: TextStyles.caption,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  List<Widget> _userDetails() => [
    _avatarWidget(_member?.image ?? ''),
    xsSpacer(),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_member?.name ?? 'Unknown', style: TextStyles.body),
        Text(
          'Crew: #${_member?.crewId ?? 'Unknown'}',
          style: TextStyles.caption.copyWith(color: AppColors.darkGrey),
        ),
      ],
    ),
  ];

  Widget _avatarWidget(String url, {bool isCompact = false}) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.xl),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.1),
          blurRadius: Dimensions.xs,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.xl),
      child: CachedNetworkImage(
        imageUrl: url,
        width: isCompact ? Dimensions.xl : Dimensions.xl * 1.5,

        height: isCompact ? Dimensions.xl : Dimensions.xl * 1.5,
        fit: BoxFit.cover,
        errorWidget:
            (context, url, error) => const Icon(
              FontAwesomeIcons.user,
              size: Dimensions.xl,
              color: AppColors.primary,
            ),
      ),
    ),
  );

  Widget _dateWidget() => Row(
    children: [
      Icon(
        FontAwesomeIcons.calendar,
        size: Dimensions.sm,
        color: AppColors.darkGrey,
      ),
      xsSpacer(),
      Text(
        '${_absence?.startDate.toDayMonthYear()} - ${_absence?.endDate.toDayMonthYear()}',
        style: TextStyles.caption.copyWith(color: AppColors.darkGrey),
      ),
    ],
  );

  Widget _timeStampWidget(DateTime? date) => Row(
    children: [
      Icon(FontAwesomeIcons.clock, size: Dimensions.sm, color: AppColors.black),
      xxsSpacer(),
      Text(date?.toDayMonthYear() ?? 'Unknown', style: TextStyles.footnote),
    ],
  );
  Widget _absenceTypeWidget() => Row(
    children: [
      Icon(
        FontAwesomeIcons.solidCircle,
        size: Dimensions.sm,
        color:
            _absence?.absenceType == AbsenceType.sickness
                ? AppColors.yellow
                : AppColors.green,
      ),
      xxsSpacer(),
      Text(
        ' ${_absence?.absenceType?.displayName ?? 'Unknown'}',
        style: TextStyles.caption.copyWith(color: AppColors.darkGrey),
      ),
    ],
  );

  List<Widget> _arrowSeparator() => [
    lgSpacer(),
    Flexible(
      child: Divider(
        color: AppColors.darkGrey.withValues(alpha: 0.2),
        thickness: 1,
      ),
    ),
    Icon(
      FontAwesomeIcons.chevronRight,
      size: Dimensions.sm,
      color: AppColors.darkGrey.withValues(alpha: 0.2),
    ),
    lgSpacer(),
  ];
}
