import 'package:albrandz_cbt_p/views/screens/rides/chat_driver_screen.dart';
import 'package:albrandz_cbt_p/views/screens/rides/ride_details_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/share_link_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class RideDetailsWidgets {
  BuildContext context;
  RideDetailsWidgets({required this.context});

  Widget pinItemView(){
    return Row(
      children: List.generate(4, (item){
        return Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            color: primaryColor,
            height: 25,
            width: 25,
            child: Center(child: Text(item.toString(),style: AppTextStyle.boldWhite(textSize: normalTextSize),)),
          ),
        );
      }),
    );
  }

  Widget driverDetailsView(){
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding/2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fillInputColor
              ),
              child: const Icon(Icons.person,size: 40,),
            ),
            20.width,
            Flexible(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                Text(
                  "Danish Ahmad",
                  style: AppTextStyle.boldBlack(textSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      '4.5 ',
                      style: AppTextStyle.normalBlack(color: semiBoldBlackTextColor),
                    ),
                    5.height,
                    Text(
                      '(154 Ratings)',
                      style:AppTextStyle.normalBlack(color: semiBoldBlackTextColor),
                    ),
                  ],
                ),
                20.height,
                Text(
                  "Toyota Camry - DL5CUU4323",
                  style: AppTextStyle.normalBlack(color: semiBoldBlackTextColor),
                ),
                5.height,
                Text(
                  'Driver is on the way... 3min',
                  style: AppTextStyle.semiBoldBlack(textSize: normalTextSize,color: primaryColor),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }

  Widget actionButtonsView(){
    var width = context.fullWidth;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonWidgets().appButtonFillOutWithIconView(CALL,callIcon,width: width*.30,onTap: ()async{
          ShareLinkHelper.makePhoneCall(INITAL_COUNTRY_CODE,INITAL_MOBILE_NUMBER);
        }),
        ButtonWidgets().appButtonFillOutWithIconView(MESSAGE,messageIcon,width:width*.60,onTap: (){
          context.toNext(const ChatDriverScreen());
        }),
      ],
    );
  }

  Widget pickupView(){
    var width = context.fullWidth;
    var height = context.fullHeight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickup From',
              style: AppTextStyle.boldBlack(textSize: normalTextSize),
            ),
            Text(
              '102 Noida Greater Noida \nExpressway, Noida, IN',
              style: AppTextStyle.normalBlack(color: semiBoldBlackTextColor),
            ),
          ],
        ),
        ButtonWidgets().appButtonFillOutView("Trip Details",width: width*.40,height: 45,onTap: (){
          AppDialogHelper.showCustomBottomSheet(context,child: const RideDetailsScreen(),height: height/2.3);
        })
      ],
    );
  }

  Widget shareRide(){
    return Container(
      color: fillInputColor,
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Share your trip with your family",style: AppTextStyle.normalBlack(),),
              Text("Share with 2 person",style: AppTextStyle.boldBlack(textSize: normalTextSize),),
            ],
          ),
          InkWell(
            onTap: (){
              ShareLinkHelper.shareLink("My Ride");
            },
            child: Column(
              children: [
                Text(SHARE,style: AppTextStyle.boldBlack(textSize: normalTextSize),),
                AppImageView().assetSVGImageView(shareIcon,color: primaryColor)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget changeRide({void Function()? onTap} ){
    return Container(
      color: fillInputColor,
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You are on the way to your destination",style: AppTextStyle.normalBlack(),),
              Text("Arrival (ETA) 12:55 PM",style: AppTextStyle.boldBlack(textSize: normalTextSize),),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Column(
              children: [
                Text("Change",style: AppTextStyle.boldBlack(textSize: normalTextSize),),
                AppImageView().assetSVGImageView(destinationIcon,color: Colors.red)
              ],
            ),
          )
        ],
      ),
    );
  }
}