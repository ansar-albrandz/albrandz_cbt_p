import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

class AppInputDecorationBorder {

  static OutlineInputBorder enabledBorder({double width = enableBorderWidth, Color color = disableBorderColor}) {
    return OutlineInputBorder(
      borderRadius: AppBorderRadius.all(),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static OutlineInputBorder focusedBorder({double width = enableBorderWidth, Color color = focusBorderColor}) {
    return OutlineInputBorder(
      borderRadius: AppBorderRadius.all(),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static OutlineInputBorder disabledBorder({double width = defaultBorderWidth, Color color = disableBorderColor}) {
    return OutlineInputBorder(
      borderRadius: AppBorderRadius.all(),
      borderSide: BorderSide.none,
    );
  }

  static OutlineInputBorder errorBorder({double width = enableBorderWidth, Color color = errorBorderColor}) {
    return OutlineInputBorder(
      borderRadius: AppBorderRadius.all(),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static OutlineInputBorder focusedErrorBorder({double width = enableBorderWidth, Color color = errorBorderColor}) {
    return OutlineInputBorder(
      borderRadius: AppBorderRadius.all(),
      borderSide: BorderSide(color: color, width: width),
    );
  }
  static OutlineInputBorder defaultBorder({double width = defaultBorderWidth, Color color = borderInputColor}) {
    return OutlineInputBorder(
      borderRadius: AppBorderRadius.all(),
      borderSide: BorderSide.none,
    );
  }
}
