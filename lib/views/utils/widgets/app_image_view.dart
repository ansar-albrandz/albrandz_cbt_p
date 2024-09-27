import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';

import '../constants/size_constants.dart';

class AppImageView {
  static Widget backGroundAssetImage(
      {required String path, required Widget child,required Size size}) {
    return Column(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(path),fit: BoxFit.fill),
          ),
        ),
        Expanded(child: child)
      ],
    );
  }

  static appLogoView({String imagePath = appLogoPath}){
    return Image.asset(imagePath,height: appLogoSize,width: appLogoSize,);
  }
}
