import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  double get fullHeight => MediaQuery.sizeOf(this).height;

  double get fullWidth => MediaQuery.sizeOf(this).width;

  get onBackPressed => Navigator.pop(this);

  toNext(Widget nextScreen) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => nextScreen));
  }
  toNextRemove(Widget nextScreen,{bool isBack = false}) {
    Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (_)=> nextScreen), (_)=>isBack);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
          String title) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(title)));
}
