import 'package:albrandz_cbt_p/views/screens/rides/cab_selection_screen.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_boders.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class CabSelectionWidgets {
  BuildContext context;
  CabSelectionWidgets({required this.context});

  Widget cabItemView(bool isTab,CabSelectionModel cab){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding-5),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.all(radius: sheetBorderRadiusSize-10),
        border: isTab?AppBorder.borderWithColor():AppBorder.borderWithoutColor()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(cab.imagePath,height: context.fullWidth*.15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cab.title,style: AppTextStyle.boldBlack(),),
              Row(
                children: [
                  AppImageView().assetSVGImageView(expiryTimeIcon,size: 30),
                  5.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cab.time,style: AppTextStyle.normalBlack(),),
                      Text(cab.estimateTime,style: AppTextStyle.normalBlack(),),
                    ],
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text("\$ ${cab.fare}",style: AppTextStyle.boldBlack()),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomView(bool isCabSelected,{required void Function()? onPressed}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          Expanded(child: isCabSelected?ButtonWidgets().appButtonFillView(NEXT,onTap: onPressed):ButtonWidgets().appButtonFillOutView(NEXT)),
        ],
      ),
    );
  }
}
