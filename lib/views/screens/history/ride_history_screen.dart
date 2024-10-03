import 'package:albrandz_cbt_p/views/screens/history/ride_history_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var view = RideHistoryWidgets(context: context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomWidgets.customAppBarView(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(rideHistoryImagePath), fit: BoxFit.fill),
        ),
        // color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CustomWidgets.screenTitleView(title: RIDE_HISTORIES, icon: rideHistoryIcon),
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
