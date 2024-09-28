
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

class AppTextStyle {

  static TextStyle normalBlack({Color? color,double? textSize}){
    return TextStyle(
      color: color?? normalBlackTextColor,
      fontSize: textSize??normalTextSize,
      letterSpacing: .8
    );
  }

  static TextStyle semiBoldBlack({Color? color,double? textSize}){
    return TextStyle(
      color: color?? semiBoldBlackTextColor,
      fontSize: textSize??semiBoldTextSize,
      fontWeight: FontWeight.normal
    );
  }

  static TextStyle boldBlack({Color? color,double? textSize}){
    return TextStyle(
      color: color?? boldBlackTextColor,
      fontSize: textSize??boldTextSize,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle normalWhite({Color? color,double? textSize}){
    return TextStyle(
      color: color?? normalWhiteTextColor,
      fontSize: textSize??normalTextSize,
    );
  }

  static TextStyle semiBoldWhite({Color? color,double? textSize}){
    return TextStyle(
      color: color?? semiBoldWhiteTextColor,
      fontSize: textSize??semiBoldTextSize,
    );
  }

  static TextStyle boldWhite({Color? color,double? textSize}){
    return TextStyle(
      color: color?? boldWhiteTextColor,
      fontSize: textSize??boldTextSize,
      fontWeight: FontWeight.bold
    );
  }
}