import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/size_constants.dart';

class AppImageView {

  static screenBackgroundImageView({required String path, required Size size}) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.fill),
      ),
    );
  }

  static appLogoView({String imagePath = appLogoPath}) {
    return Image.asset(
      imagePath,
      height: appLogoSize,
      width: appLogoSize,
    );
  }

  Widget assetSVGImageView(String path, {Color? color, double size = appIconSize}) =>
      SvgPicture.asset(
        path,
        color: color,
        height: size,
        width: size,
      );
}
