import 'package:albrandz_cbt_p/views/screens/rides/ride_completed_screen.dart';
import 'package:albrandz_cbt_p/views/screens/rides/widgets/ride_details_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class RideDriverDetailsScreen extends StatelessWidget {
  const RideDriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var view = RideDetailsWidgets(context: context);
    var height = context.fullHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(PIN_FOR_THIS_RIDE,style: AppTextStyle.boldBlack(textSize: normalTextSize,color: primaryColor)),
               5.width,
                Flexible(child: SizedBox(
                  width: 130,
                    child: view.pinItemView()))
              ],
            ),
            const Divider(thickness: defaultBorderWidth,),
            view.driverDetailsView(),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: view.actionButtonsView(),
            ),
            10.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: view.pickupView(),
            ),
            10.height,
            view.shareRide(),
            const Divider(thickness: defaultBorderWidth,height: 1,color: Colors.white,),
            view.changeRide(onTap: (){
              AppDialogHelper.showCustomBottomSheet(context, child: destinationRideFare(context),height: height/3.2);
            }),
            10.height,
          ],
        ),
      ),
    );
  }

  Widget destinationRideFare(BuildContext context){
    var width = context.fullWidth;
    var height = context.fullHeight;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(DESTINATION_CHANGE,style: AppTextStyle.boldBlack(),),
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
                    Text(TRIP_FARE,style: AppTextStyle.normalBlack(textSize: boldTextSize),),
                    Text("\$ 21.4",style: AppTextStyle.boldBlack(textSize: boldTextSize),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(EXTRA_FARE,style: AppTextStyle.normalBlack(textSize: boldTextSize,),),
                    Text("+\$ 15.4",style: AppTextStyle.boldBlack(textSize: boldTextSize,color: Colors.green),),
                  ],
                ),
                5.height,
                const Divider(thickness: defaultBorderWidth+1,height: 2,),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(TOTAL_PAY,style: AppTextStyle.boldBlack(textSize: boldTextSize),),

                    Text("-\$ 6.4",style: AppTextStyle.boldBlack(textSize: boldTextSize),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
                  child: ButtonWidgets().appButtonFillView(OK,onTap: (){
                    AppDialogHelper.showCustomBottomSheet(context, child: const RideCompletedScreen(),height: height/2);
                  },width: width/2.5),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
