import 'package:flutter/material.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class AbsenceStatusWidget extends StatelessWidget {
  const AbsenceStatusWidget({required this.status, super.key});

  final AbsenceStatus? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.xs,
        vertical: Dimensions.xs,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimensions.md),
        border: Border.all(color: _getStatusColor()),
      ),
      child: Text(
        status?.displayName ?? 'Unknown',
        style: TextStyles.footnote.copyWith(color: _getStatusColor()),
      ),
    );
  }

  Color _getStatusColor() {
    return status == AbsenceStatus.confirmed
        ? AppColors.green
        : status == AbsenceStatus.rejected
        ? AppColors.red
        : AppColors.orange;
  }
}
