import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RideHistoryWidgets {
  BuildContext context;
  RideHistoryWidgets({required this.context});

  Widget titleView() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.history,
            size: 50,
          ),
          Text(
            "Ride History",
            style: AppTextStyle.boldBlack(),
          ),
        ],
      ),
    ),
  );

  Widget historyItemView(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today 10:15 AM",
                style: AppTextStyle.boldBlack(textSize: semiBoldTextSize+2),
              ),
              Text(
                "Toyota Camery Large CRM",
                style: AppTextStyle.semiBoldBlack(),
              ),
              Row(
                children: [
                  AppImageView().assetSVGImageView(startToEndRideIcon,size: 40),
                  10.width,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Al Nahada -1 Dubai, United Arab Emirates",
                          style: AppTextStyle.normalBlack(),
                        ),
                        10.height,
                        Text(
                          "2130 St - Part Saeed, Dubai, UAE",
                          style: AppTextStyle.normalBlack(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          "43.00",
          style: AppTextStyle.boldBlack(textSize: 14),
        ),
      ],
    );
  }

}