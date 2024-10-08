import 'package:albrandz_cbt_p/views/screens/card/add_card_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/widgets/profile_view_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/rides/payment_success_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class RideCompletedScreen extends StatelessWidget {
  const RideCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;
    var view = ProfileViewWidgets(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Arrived Your destination",style: AppTextStyle.boldBlack(),),
            10.height,
            const Divider(thickness: defaultBorderWidth,height: 1,),
            5.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Distance",style: AppTextStyle.normalBlack(textSize: normalTextSize),),
                      Text("15.3 Kms",style: AppTextStyle.boldBlack(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(TRIP_FARE,style: AppTextStyle.normalBlack(textSize: normalTextSize),),
                      Text("\$16.0",style: AppTextStyle.boldBlack(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(TAX,style: AppTextStyle.normalBlack(textSize: normalTextSize),),
                      Text("\$ 4",style: AppTextStyle.boldBlack(),),
                    ],
                  ),
                  5.height,
                  const Divider(thickness: defaultBorderWidth+1,height: 2,),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(TOTAL_PAY,style: AppTextStyle.boldBlack(textSize: boldTextSize),),
                      Text("\$ 20",style: AppTextStyle.boldBlack(textSize: boldTextSize),),
                    ],
                  ),
                ],
              ),
            ),
            10.height,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding+5),
              color: fillInputColor,
              child: Row(
                children: [
                  AppImageView().assetSVGImageView(cashIcon,size: appIconSize-5),
                  10.width,
                  Text(
                    CASH,
                    style: AppTextStyle.boldBlack(textSize: normalTextSize,color: semiBoldBlackTextColor),
                  )
                ],
              ),
            ),
            const Divider(thickness: 1,color: Colors.white,height: 1,),
            Container(
              padding: const EdgeInsets.only(left: horizontalPadding),
              color: const Color(0xffe8e7ec),
              child:  view.infoFieldView(
                  title: ADD_CARD,
                  leadingIcon: creditCardIcon,
                  trailingButton: IconButton(
                      onPressed: () {
                        context.toNext(AddCardScreen());
                      },
                      icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add),
                      ))),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
              child: ButtonWidgets().appButtonFillView(PAY,onTap: (){
                // context.toNext(const DrawerScreen());
                AppDialogHelper.showCustomBottomSheet(context, child: const PaymentSuccessScreen(),height: height/2.5);

              },width: width),
            )
          ],
        ),
      ),
    );
  }
}
