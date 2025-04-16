import 'package:flutter/material.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class TextStyles {
  TextStyles._();

  static const TextStyle title = TextStyle(
    fontSize: Dimensions.lg,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: Dimensions.md,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

   static const TextStyle header = TextStyle(
    fontSize: Dimensions.xmd,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle body = TextStyle(
    fontSize: Dimensions.sm,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle caption = TextStyle(
    fontSize: Dimensions.sm - 2,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle footnote = TextStyle(
    fontSize: Dimensions.sm - 4,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
