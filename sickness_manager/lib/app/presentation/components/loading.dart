import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shimmer/shimmer.dart';
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

Widget inlineLoader() => SizedBox(
  height: Dimensions.md,

  child: LoadingIndicator(
    indicatorType: Indicator.lineScale,

    colors: const [AppColors.black],
    strokeWidth: 2,
    backgroundColor: Colors.transparent,
    pathBackgroundColor: Colors.transparent,
  ),
);

Widget cardLoader() => SizedBox(
  height: 1.25 * Dimensions.xxl,
  child: Shimmer.fromColors(
    baseColor: AppColors.lightGrey.withValues(alpha: 0.4),
    highlightColor: AppColors.lightGrey.withValues(alpha: 0.1),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(Dimensions.xs),
      ),
      padding: Paddings.allSm,
      child: Row(
        children: [
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Dimensions.xs),
            ),
          ),
          smSpacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.xxl,
                height: Dimensions.sm,
                color: AppColors.white,
              ),
              xxsSpacer(),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendar,
                    size: Dimensions.sm,
                    color: AppColors.darkGrey,
                  ),
                  xsSpacer(),
                  Container(
                    width: Dimensions.xxl,
                    height: Dimensions.sm,
                    color: AppColors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
