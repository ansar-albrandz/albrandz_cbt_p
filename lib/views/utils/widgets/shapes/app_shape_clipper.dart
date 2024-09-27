
import 'package:albrandz_cbt_p/views/utils/widgets/shapes/rectangle_curve_out_clipper.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/shapes/rectangular_curve_in_clipper.dart';
import 'package:flutter/cupertino.dart';

class AppShapeClipper {

  static Widget rectangleCurveInView(String assets,double height, double width,{BoxFit fit = BoxFit.cover}){
    return ClipPath(
      clipper: RectangleCurveInClipper(),
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          assets,
          fit: fit,
        ),
      ),
    );
  }

  static Widget rectangleCurveOutView(Widget child,double height, double width,{BoxFit fit = BoxFit.cover}){
    return ClipPath(
      clipper: RectangleWithCurveOutClipper(),
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}