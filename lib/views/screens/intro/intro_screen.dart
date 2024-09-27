import 'package:albrandz_cbt_p/views/screens/login/login_screen.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageView.screenBackgroundImageImage(path: splashImagePath, size: Size(width, height*0.80)),
            60.height,
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
                child: ButtonWidgets().introButtonView(LET_GET_RIDES,
                    width: width, onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
