import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/views/screens/home/widgets/home_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/screens/saved_places/saved_places_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
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
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var height = context.fullHeight;
    var width = context.fullWidth;
    var view = HomeWidgets(context: context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AppImageView.screenBackgroundImageView(
                    path: homeImagePath, size: Size(width, height * .25)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      60.height,
                      view.searchView(),
                      view.drawerListItemView(
                          title: "Recents",
                          prefixIcon: calenderIcon,
                          color: semiBoldBlackTextColor),
                      view.drawerListItemView(
                          title: SAVED_PLACES,
                          prefixIcon: savedPlacesIcon,
                          color: semiBoldBlackTextColor,
                          onTap: () {
                            context.toNext(const SavedPlacesScreen());
                          }),
                      10.height,
                      view.suggestionTitleView(),
                      10.height,
                      Row(
                        children: [
                          Expanded(
                            child: view.suggestionItemView(
                                title: BOOK_NOW, imagePath: rideCarImagePath),
                          ),
                          10.width,
                          Expanded(
                            child: view.suggestionItemView(
                                title: SCHEDULE, imagePath: calenderImagePath),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                10.height,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(banners.length, (index) {
                      return Image.asset(
                        banners[index],
                        height: height * .15,
                        width: width - 20,
                      );
                    }),
                  ),
                ),
                10.height,
              ],
            ),
          ),
          Positioned(
              top: height * .15,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 Obx(()=>InkWell(
                   onTap: (){
                     context.toNext(const ProfileViewScreen());
                   },
                   child: Container(
                       height: profileImageSize-30,
                       width: profileImageSize-30,
                       decoration: BoxDecoration(
                         border: Border.all(width: defaultBorderWidth),
                           color: Colors.grey.shade200,
                           borderRadius:
                           BorderRadius.circular((profileImageSize-30) / 2)),
                       child: profileController.imageUri.value.isEmpty
                           ?  CircleAvatar(
                         backgroundColor: Colors.grey.shade200,
                         child: const Icon(Icons.person,
                             size: 60, color: Colors.grey),
                       )
                           : CircleAvatar(
                         backgroundImage: NetworkImage(FILE_PATH_URL +
                             profileController.imageUri.value),
                       )),
                 )),
                  5.height,
                  Text(
                    getGreetingBasedOnTime(),
                    style: AppTextStyle.boldBlack(textSize: normalTextSize,color: primaryColor),
                  ),
                  Obx(()=>Text(
                    profileController.profileData.value.name ?? "NA",
                    style: AppTextStyle.boldBlack(textSize: boldTextSize-2,color: primaryColor),
                  ))
                ],
              )),
        ],
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
