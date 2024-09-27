import 'package:flutter/material.dart';

import '../constants/size_constants.dart';

class AppBorderRadius {
  static BorderRadius circular({
    double? radius,
  }) {
    return BorderRadius.circular(radius ?? borderRadiusSize);
  }

  static BorderRadius symmetric({
    double? horizontal,
    double? vertical,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(horizontal ?? borderRadiusSize),
      topRight: Radius.circular(horizontal ?? borderRadiusSize),
      bottomLeft: Radius.circular(vertical ?? borderRadiusSize),
      bottomRight: Radius.circular(vertical ?? borderRadiusSize),
    );
  }

  static BorderRadius all({
    double? radius,
  }) {
    return BorderRadius.all(Radius.circular(radius ?? borderRadiusSize));
  }

  static BorderRadius only({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? borderRadiusSize),
      topRight: Radius.circular(topRight ?? borderRadiusSize),
      bottomLeft: Radius.circular(bottomLeft ?? borderRadiusSize),
      bottomRight: Radius.circular(bottomRight ?? borderRadiusSize),
    );
  }
}



