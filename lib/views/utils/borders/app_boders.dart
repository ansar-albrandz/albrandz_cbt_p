import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

class AppBorder {
  static Border borderWithColor({
    Color? color,
    double? width,
  }) {
    return Border.all(
      color: color ?? borderInputColor, // Default color if none is provided
      width: width ?? defaultBorderWidth,          // Default width if none is provided
    );
  }

  static Border borderWithoutColor({
    double? width,
  }) {
    return Border.all(
      color: Colors.transparent, // No color means transparent
      width: width ?? defaultBorderWidth,       // Default width if none is provided
    );
  }
}
