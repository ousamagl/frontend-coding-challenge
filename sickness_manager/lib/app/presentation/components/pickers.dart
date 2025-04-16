import 'package:flutter/material.dart';
import 'package:sickness_manager/app/core/common/extensions/date_time_extensions.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

Widget choicePicker({
  required String label,
  required IconData icon,
  required List<String> options,
  required String? selectedValue,
  required Function(String?) onChanged,
}) {
  return Container(
    padding: Paddings.allSm,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: Dimensions.sm),
            smSpacer(),
            Text(label, style: TextStyles.body),
          ],
        ),
        smSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              options.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(right: Dimensions.xs),
                  child: InkWell(
                    onTap: () {
                      onChanged(option);
                    },
                    borderRadius: BorderRadius.circular(Dimensions.sm),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.xs,
                        horizontal: Dimensions.sm,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selectedValue == option
                                ? AppColors.orange
                                : AppColors.lightGrey.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(Dimensions.xs),
                        boxShadow: [
                          if (selectedValue == option)
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.1),
                              blurRadius: 4.0,
                            ),
                        ],
                      ),
                      child: Text(option, style: TextStyles.caption),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    ),
  );
}

Widget dropDownPicker<T>({
  required String label,
  required IconData icon,
  required T? value,
  required List<T> items,
  required Function(T?) onChanged,
}) {
  return Container(
    padding: Paddings.allSm,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
    child: Row(
      children: [
        Icon(icon, size: Dimensions.sm),
        smSpacer(),
        Text(label, style: TextStyles.body),
        Spacer(),
        DropdownButton<T>(
          value: value,
          onChanged: onChanged,
          dropdownColor: AppColors.secondary,
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
        ),
      ],
    ),
  );
}

Widget datePicker(
  BuildContext context, {
  required String label,
  required IconData icon,
  required DateTime? selectedDate,
  required Function(DateTime) onDateSelected,
}) {
  return Container(
    padding: Paddings.allSm,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(Dimensions.xs),
    ),
    child: Row(
      children: [
        Icon(icon, size: Dimensions.sm),
        smSpacer(),
        Text(label, style: TextStyles.body),
        Spacer(),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),

              builder: (BuildContext context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(primary: AppColors.primary),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.xs,
              horizontal: Dimensions.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(Dimensions.xs),
            ),
            child: Text(
              selectedDate != null
                  ? selectedDate.toDayMonthYear()
                  : 'Select Date',
              style: TextStyles.caption,
            ),
          ),
        ),
      ],
    ),
  );
}
