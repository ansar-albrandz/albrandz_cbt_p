import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/views/screens/home/widgets/home_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/saved_places/saved_places_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final AdvancedDrawerController controller;
   HomeScreen({super.key, required this.controller});

  final banners = [banner1Path, banner2Path, banner3Path];

  final suggestions = [
    {"title": "Ride", "image": rideCarImagePath},
    {"title": "Rental", "image": rentalCarImagePath},
    {"title": "Reserve", "image": calenderImagePath}
  ];
  var profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var height = context.fullHeight;
    var width = context.fullWidth;
    var view = HomeWidgets(context: context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreetingBasedOnTime(),
              style: AppTextStyle.boldWhite(textSize: 14),
            ),
            Text(
              profileController.profileData.value.name ?? "NA",
              style: AppTextStyle.boldWhite(textSize: 20),
            )
          ],
        )),
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                iconSize: 20,
                onPressed: controller.showDrawer,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: controller,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppImageView.screenBackgroundImageView(
                path: homeImagePath, size: Size(width, height * .25)),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  view.searchView(),
                  view.drawerListItemView(
                      title: "Recents",
                      prefixIcon: calenderIcon,
                      color: semiBoldBlackTextColor),
                  view.drawerListItemView(
                      title: SAVED_PLACES,
                      prefixIcon: savedPlacesIcon,
                      color: semiBoldBlackTextColor,onTap: (){
                        context.toNext(const SavedPlacesScreen());
                  }),
                  10.height,
                  // view.suggestionTitleView(),
                  // 10.height,
                  // SizedBox(
                  //   height: height * .13,
                  //   child: GridView.builder(
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       itemCount: suggestions.length,
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 3),
                  //       itemBuilder: (_, index) {
                  //         return view.suggestionItemView(
                  //             title: suggestions[index]['title'].toString(),
                  //             imagePath:
                  //                 suggestions[index]['image'].toString());
                  //       }),
                  // ),
                  SizedBox(
                    height: height * .15,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: banners.length,
                      itemBuilder: (_, index) {
                        return Image.asset(banners[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.width;
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getGreetingBasedOnTime() {
  final currentTime = DateTime.now().hour;

  if (currentTime >= 5 && currentTime < 12) {
    return "Good Morning";
  } else if (currentTime >= 12 && currentTime < 17) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}
