import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

Widget defaultLoader() => SizedBox(
  height: Dimensions.xl,

  child: LoadingIndicator(
    indicatorType: Indicator.lineScale,

    colors: const [AppColors.orange],
    strokeWidth: 2,
    backgroundColor: Colors.transparent,
    pathBackgroundColor: Colors.transparent,
  ),
);
