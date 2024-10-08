import 'package:albrandz_cbt_p/views/screens/rides/rate_driver_screen.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Payment successful",style: AppTextStyle.boldBlack(),),
          10.height,
          const Divider(thickness: defaultBorderWidth,height: 1,),
          5.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                20.height,
                Center(
                  child:  Text("\$ 198.00",style: AppTextStyle.boldBlack(textSize: boldTextSize,color: Colors.green),),
                ),
                30.height,
                const Icon(Icons.check_circle,color: Colors.green,size: 60,),
                10.height,
                const Text("\$ 198 has been deducted from your bank account"),
                30.height,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
            child: ButtonWidgets().appButtonFillView("Review",onTap: (){
              AppDialogHelper.showCustomBottomSheet(context, child: const RateDriverScreen(),height: height/2);
            },width: width),
          )
        ],
      ),
    );
  }
}
