import 'package:flutter/material.dart';

class Dimensions {
  Dimensions._();

  static const _base = 8.0;

  /// 4
  static const xxs = _base / 2;

  /// 8
  static const xs = _base;

  /// 16
  static const sm = _base * 2;

  /// 20
  static const xmd = _base * 2.5;

  /// 24
  static const md = _base * 3;

  /// 32
  static const lg = _base * 4;

  /// 40
  static const xl = _base * 5;

  /// 80
  static const xxl = _base * 10;
}

/// 4
Widget xxsSpacer() => _spacer(Dimensions.xxs);

/// 8
Widget xsSpacer() => _spacer(Dimensions.xs);

/// 16
Widget smSpacer() => _spacer(Dimensions.sm);

/// 24
Widget mdSpacer() => _spacer(Dimensions.md);

/// 32
Widget lgSpacer() => _spacer(Dimensions.lg);

/// 40
Widget xlSpacer() => _spacer(Dimensions.xl);

/// 80
Widget xxlSpacer() => _spacer(Dimensions.xxl);

/// 100
Widget xxxlSpacer() => _spacer(Dimensions.xxl * 1.25);

Widget _spacer(double size) => SizedBox(height: size, width: size);
