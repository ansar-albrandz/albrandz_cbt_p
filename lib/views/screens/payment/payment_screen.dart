import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/assets_path.dart';
import '../../utils/widgets/custom_widgets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
              image: AssetImage(contactUsImagePath), fit: BoxFit.fill),
        ),
        // color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CustomWidgets.screenTitleView(title: PAYMENTS,icon: transactionsIcon),
            80.height,
            Center(
              child: Text("On Going..."),
            )
            // SizedBox(
            //   height: screenSize.height,
            //   child: const WebViewHelper(url: contactUrl),
            // )
          ],
        ),
      ),
    );
  }
}
