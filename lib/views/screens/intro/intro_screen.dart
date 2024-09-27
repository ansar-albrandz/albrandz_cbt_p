import 'package:albrandz_cbt_p/views/screens/login/login_screen.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
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
      body: AppImageView.backGroundAssetImage(path: splashImagePath, child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonWidgets().introButtonView(LET_GET_RIDES,
                size: Size(width, 55), onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                }),
          ),
        ),
      ), size: Size(width, height*0.82)),
      // body: SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       Image.asset(splashImagePath),
      //       // AppShapeClipper.rectangleCurveInView(
      //       //     "assets/images/cab_intro.jpg", height * 0.80, width),
      //       60.height,
      //       Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: ButtonWidgets().introButtonView(LET_GET_RIDES,
      //             size: Size(width, 60), onTap: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      //         }),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
