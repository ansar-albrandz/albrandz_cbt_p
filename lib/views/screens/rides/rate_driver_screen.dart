import 'package:albrandz_cbt_p/views/screens/rides/ride_map_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RateDriverScreen extends StatelessWidget {
  const RateDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Rate the driver",
            style: AppTextStyle.boldBlack(),
          ),
          10.height,
          const Divider(
            thickness: defaultBorderWidth,
            height: 1,
          ),
          5.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${getCurrentDayName()}, ",
                      style: AppTextStyle.normalBlack(),
                    ),
                    Text(
                      getCurrentDateAndTime(),
                      style: AppTextStyle.normalBlack(),
                    ),
                  ],
                ),
                10.height,
                RatingBar(
                    alignment: Alignment.center,
                    isHalfAllowed: true,
                    size: 40,
                    filledColor: primaryColor,
                    halfFilledIcon: Icons.star_half_outlined,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    onRatingChanged: (value) {}),
                10.height,
                TextFormField(
                  controller: TextEditingController(),
                  maxLines: 4,
                  maxLength: 150,
                  decoration: InputDecoration(fillColor: fillInputColor,filled: true,hintText: "Write your review",hintStyle: AppTextStyle.semiBoldBlack(textSize: normalTextSize)),
                ),
                30.height,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: ButtonWidgets().appButtonFillView(SUBMIT, onTap: () {
              // AppDialogHelper.showCustomBottomSheet(context,
              //     child: const PaymentSuccessScreen(), height: height / 2.5);
              context.toNext(RideMapScreen());
            }, width: width),
          ),
          10.height,
        ],
      ),
    );
  }

  String getCurrentDayName() {
    DateTime now = DateTime.now();
    List<String> dayNames = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];

    return dayNames[
        now.weekday]; // DateTime.weekday returns 1 for Monday, 7 for Sunday
  }

  String getCurrentDateAndTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd MMM hh:mm a');
    return formatter.format(now);
  }
}
