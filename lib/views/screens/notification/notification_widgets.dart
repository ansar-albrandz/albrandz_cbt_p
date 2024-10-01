import 'package:flutter/material.dart';
import '../../utils/constants/size_constants.dart';
import '../../utils/styles/app_text_style.dart';

class NotificationWidgets {
  BuildContext context;
  NotificationWidgets({required this.context});

  Widget titleView() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.notifications_active_rounded,
            size: 50,
          ),
          Text(
            "Notifications",
            style: AppTextStyle.boldBlack(),
          ),
        ],
      ),
    ),
  );

  Widget historyItemView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "8 min ago",
          style: AppTextStyle.normalBlack(),
        ),
        Text(
          "Ride Check",
          style: AppTextStyle.boldBlack(textSize: 14),
        ),
        Text(
          "When you choose a cancelled ride & travel off the app, you compromise your safety.",
          style: AppTextStyle.normalBlack(),
        )
      ],
    );
  }
}