import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/helpers/webview_helper.dart';
import '../../utils/widgets/custom_widgets.dart';

class AboutUsScreen  extends StatelessWidget {
  const AboutUsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomWidgets.customAppBarView(),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(aboutUsImagePath), fit: BoxFit.fill),
        ),
        // color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CustomWidgets.screenTitleView(title: ABOUTE_US,icon: Icons.info),
            80.height,
            SizedBox(
              height: screenSize.height,
              child: const WebViewHelper(url: aboutUsUrl),
            )
          ],
        ),
      ),
    );
  }
}
