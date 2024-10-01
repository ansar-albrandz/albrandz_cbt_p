import 'package:flutter/material.dart';

import '../constants/size_constants.dart';
import '../styles/app_text_style.dart';

class CustomWidgets {
  static AppBar customAppBarView(){
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade400,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  static Widget screenTitleView({required String title,required IconData icon}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           Icon(
            icon,
            size: 50,
          ),
          Text(
            title,
            style: AppTextStyle.boldBlack(),
          ),
        ],
      ),
    ),
  );
}

