import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';

import '../borders/app_border_radius.dart';

class ButtonWidgets {

  Widget introButtonView(String title, {double? width,double height = defaultHeightOfButton,void Function()? onTap}){
    return Card(
      shape: _buttonBorderRadius(),
      margin: EdgeInsets.zero,
      color: primaryColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.circular(),
        child: SizedBox(
          height: height,
          width: width ?? 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,style: AppTextStyle.boldWhite(),),
              10.width,
              const Icon(Icons.arrow_forward,color: primaryIconColor,)
            ],
          ),
        ),
      ),
    );
  }

  Widget appButtonFillView(String title, {double? width,double height = defaultHeightOfButton,void Function()? onTap}){
    return Card(
      shape: _buttonBorderRadius(),
      margin: EdgeInsets.zero,
      color: primaryColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.circular(),
        child: SizedBox(
          height: height,
          width: width ?? 200,
          child: Center(
            child: Text(title,style: AppTextStyle.boldWhite(),),
          ),
        ),
      ),
    );
  }

  Widget appButtonFillOutView(String title, {double? width,double height = defaultHeightOfButton,void Function()? onTap}){
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(side: const BorderSide(width: 1,color: Colors.grey),borderRadius: AppBorderRadius.circular()),
      color: Colors.white,
      child: InkWell(
        borderRadius: AppBorderRadius.circular(),
        onTap: onTap,
        child: SizedBox(
          height: height,
          width: width ?? 200,
          child: Center(
            child: Text(title,style: AppTextStyle.boldBlack(color: primaryColor),),
          ),
        ),
      ),
    );
  }

  _buttonBorderRadius()=> RoundedRectangleBorder(
    borderRadius: AppBorderRadius.circular()
  );

  Widget backButton(){
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey.shade400,
      child: BackButton(
        // icon: const Icon(
        //   Icons.arrow_back,
        //   size: 20,
        // ),
        // onPressed: () {
        //   Get.back();
        // },
      ),
    );
  }
}
