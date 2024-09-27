import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/text_style_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/widget_extensions.dart';
import 'package:lottie/lottie.dart';

class LoaderBuilder {
  BuildContext context;

  LoaderBuilder({required this.context});

  showLoader({String title = "Loading..."}) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(
                  color: primaryColor,
                ),
                10.width,
                Text(
                  title,
                  style: TextStyle().primaryTextStyle,
                )
              ],
            ).paddingAll(10),
          );
        });
  }

  dismissLoader() {
    context.onBackPressed;
  }

  showFullScreenLoader({String? path}) {
    context.toNext(FullScreenLoaderView(path: path));
  }
}

class FullScreenLoaderView extends StatelessWidget {
  final String? path;

  const FullScreenLoaderView({required this.path});

  @override
  Widget build(BuildContext context) {
    double size = 160;
    return Scaffold(
      body: circleView(Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
            child: Lottie.asset(path ?? carAnimationPath, width: size-20)),
      )),
    );
  }

  Widget circleView(Widget child){
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: 150, // Adjust the width and height of the loader
            height: 150,
            child: CircularProgressIndicator(
              strokeWidth: 3.0, // Adjust the thickness
              valueColor: AlwaysStoppedAnimation<Color>(canAnimationBorderColor), // Change color
            ),
          ),

          // Widget inside the circular progress indicator
          child,
        ],
      ),
    );
  }
}
