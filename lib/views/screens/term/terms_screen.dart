import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/webview_helper.dart';
import 'package:flutter/material.dart';
import '../../utils/widgets/custom_widgets.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});


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
              image: AssetImage(termsConditionImagePath), fit: BoxFit.fill),
        ),
        // color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CustomWidgets.screenTitleView(title: TERM_CONDITIONS,icon: termsAndPolicyIcon),
            80.height,
            SizedBox(
              height: screenSize.height,
              child: const WebViewHelper(url: termConditionUrl),
            )
          ],
        ),
      ),
    );
  }
}
