import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/double_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/widgets/button_widgets.dart';

class ProfileSuccessScreen extends StatelessWidget {
  const ProfileSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var view = ProfileWidgets(context: context);
    var height = context.fullHeight;
    var width = context.fullWidth;

    return Scaffold(
      body: AppImageView.backGroundAssetImage(path: submittedSuccessImagePath, child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            30.height,
            Lottie.asset('assets/lotties/done.json',height: 100,width: 100,fit: BoxFit.cover),
            20.height,
            view.fieldTitleTextView(
                "Your Profile has been submitted successfully!"),
            (height * .20).height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ButtonWidgets().appButtonFillView(NEXT, onTap: () {
                context.toNext(ProfileViewScreen());
              }, width: width),
            ),
            20.height,
          ],
        ),
      ), size: Size(width, height*.52)),
    );
  }
}
