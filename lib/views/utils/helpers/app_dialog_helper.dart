import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
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
}
