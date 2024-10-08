import 'package:albrandz_cbt_p/views/screens/home/drawer_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class CancelRideScreen extends StatefulWidget {
  const CancelRideScreen({super.key});

  @override
  State<CancelRideScreen> createState() => _CancelRideScreenState();
}

class _CancelRideScreenState extends State<CancelRideScreen> {

  int? selectedReasonIndex;
  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(CANCELLATION_REASONS,style: AppTextStyle.boldBlack(),),
            10.height,
            const Divider(thickness: defaultBorderWidth,height: 1,),
            5.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: List.generate(cancelReasons.length, (index){
                  return RadioListTile<int>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(cancelReasons[index]),
                    value: index,
                    groupValue: selectedReasonIndex,
                    onChanged: (int? value) {
                      setState(() {
                        selectedReasonIndex = value;
                      });
                    },
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
              child: selectedReasonIndex != null?ButtonWidgets().appButtonFillView(CANCEL_RIDE,width: width,onTap: (){
                AppDialogHelper.showCustomBottomSheet(context, child: cancelRideFare(),height: height/3.2);
              }):ButtonWidgets().appButtonFillOutView(CANCEL_RIDE,width: width,onTap: (){
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget cancelRideFare(){
    var width = context.fullWidth;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(CANCELLATION_FARE,style: AppTextStyle.boldBlack(),),
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
                    Text(CANCELLATION_FARE,style: AppTextStyle.normalBlack(textSize: boldTextSize,color: errorBorderColor),),
                    Text("-\$ 15.4",style: AppTextStyle.boldBlack(textSize: boldTextSize,color: errorBorderColor),),
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
                    context.toNextRemove(const DrawerScreen());
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


