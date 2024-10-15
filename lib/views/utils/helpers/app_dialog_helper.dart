import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';

class AppDialogHelper {

  showCustomDialog(BuildContext context,
      {required void Function()? onPressed,required String title, required String message}) {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.all()),
              actions: [
                TextButton(
                    onPressed: onPressed,
                    child: Text(
                      SURE,
                      style:  AppTextStyle.semiBoldBlack(color: Colors.green),
                    )),
                // 10.width,
                TextButton(
                    onPressed: () {
                      context.onBackPressed;
                    },
                    child: Text(
                      NOT_NOW,
                      style:  AppTextStyle.semiBoldBlack(color: Colors.red),
                    ))
              ],
              title:  Text(title,style: AppTextStyle.boldBlack(),),
              content:  Text(message,style: AppTextStyle.normalBlack()),
            ));
  }

  static showCustomBottomSheet(BuildContext context,{required Widget child,double? height}){
    var width = context.fullWidth;
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius:AppBorderRadius.only(topRight: sheetBorderRadiusSize,topLeft: sheetBorderRadiusSize)
      ),
        context: context, builder: (_){
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppBorderRadius.only(topRight: sheetBorderRadiusSize,topLeft: sheetBorderRadiusSize)
        ),
        child: Column(
          children: [
            10.height,
            Container(
              width: 90,
              height: 6,
              decoration: BoxDecoration(
                color: disableBorderColor,
                borderRadius: AppBorderRadius.all()
              ),
            ),
            10.height,
            Expanded(child: child)
          ],
        ),
      );
    });
  }

}
