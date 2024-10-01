import 'package:albrandz_cbt_p/views/screens/notification/notification_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/size_constants.dart';
import '../../utils/widgets/custom_widgets.dart';

class NotificationScreen  extends StatelessWidget {
  const NotificationScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var view = NotificationWidgets(context: context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomWidgets.customAppBarView(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(notificationImagePath), fit: BoxFit.fill),
        ),
        // color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            view.titleView(),
            80.height,
            SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  itemBuilder: (_, index) {
                    return view.historyItemView();
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(thickness: defaultBorderWidth,);
                  },
                  itemCount: 5),
            ),

            // SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
