import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/webview_helper.dart';
import 'package:flutter/material.dart';
import '../../utils/widgets/custom_widgets.dart';

class TermsScreen extends StatelessWidget {
  final String url;
  final String title;
   const TermsScreen({super.key, required this.url, required this.title});


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
        child: Column(
          children: [
            90.height,
            CustomWidgets.screenTitleView(title: title,icon: termsAndPolicyIcon),
            70.height,
            Expanded(child: WebViewHelper(url: url))
          ],
        ),
      ),
    );
  }
}
