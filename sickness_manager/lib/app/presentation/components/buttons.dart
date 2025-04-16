import 'package:flutter/material.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

Widget primaryFilledButton(
  String text, {
  VoidCallback? onPressed,
  Color? color,
  Color? textColor,
  double? width,
  bool isLoading = false,
}) => SizedBox(
  width: width ?? double.infinity,
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.sm - 2),
      backgroundColor: color ?? AppColors.orange,
      disabledBackgroundColor: AppColors.orange.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.xs),
      ),
    ),
    child:
        isLoading
            ? inlineLoader()
            : Text(
              text,
              style: TextStyles.body.copyWith(
                color: textColor ?? AppColors.black,
              ),
            ),
  ),
);

Widget primaryOutlinedButton(
  String text, {
  VoidCallback? onPressed,
  Color? color,
  Color? textColor,
  double? width,
}) => SizedBox(
  width: width ?? double.infinity,
  child: OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.sm - 2),
      backgroundColor: AppColors.white,
      side: BorderSide(color: color ?? AppColors.orange),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.xs),
      ),
    ),
    child: Text(
      text,
      style: TextStyles.body.copyWith(color: textColor ?? AppColors.orange),
    ),
  ),
);
