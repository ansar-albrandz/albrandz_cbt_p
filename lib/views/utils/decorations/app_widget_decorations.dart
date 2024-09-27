import 'package:albrandz_cbt_p/views/utils/borders/app_boders.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

import '../borders/app_border_radius.dart';

class AppBoxDecoration {
  static BoxDecoration solidColor({
    required Color color,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: AppBorderRadius.all(),
    );
  }

  static BoxDecoration gradient({
    required Gradient gradient,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: AppBorderRadius.all(),
    );
  }

  static BoxDecoration border({Color? color,double? width = defaultBorderWidth}) {
    return BoxDecoration(
      border: AppBorder.borderWithColor(width: width,color: color),
      borderRadius: AppBorderRadius.all(),
    );
  }

  static BoxDecoration shadow({
    required Color shadowColor,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
  }) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: AppBorderRadius.all(),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }

  static BoxDecoration custom({
    Color? color,
    Gradient? gradient,
    Color? borderColor,
    double borderWidth = 1.0,
    Color shadowColor = Colors.black12,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
  }) {
    return BoxDecoration(
      color: color ?? Colors.transparent,
      gradient: gradient,
      border: borderColor != null ? Border.all(color: borderColor, width: borderWidth) : null,
      borderRadius: AppBorderRadius.all(),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }
}
