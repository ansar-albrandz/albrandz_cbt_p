import 'package:albrandz_cbt_p/controllers/app/app_info_controller.dart';
import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/views/screens/about/about_us_screen.dart';
import 'package:albrandz_cbt_p/views/screens/contact_us/contact_us_screen.dart';
import 'package:albrandz_cbt_p/views/screens/history/ride_history_screen.dart';
import 'package:albrandz_cbt_p/views/screens/home/home_screen.dart';
import 'package:albrandz_cbt_p/views/screens/home/widgets/home_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/notification/notification_screen.dart';
import 'package:albrandz_cbt_p/views/screens/payment/payment_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/screens/saved_places/saved_places_screen.dart';
import 'package:albrandz_cbt_p/views/screens/term/terms_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/share_link_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../utils/constants/constants.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  final _appInfoController = Get.put(AppInfoController());
  final _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _profileController.getProfile();
    _profileController.getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context: context);
    return AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: primaryColor,
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  view.drawerListItemView(
                      title: PROFILE,
                      prefixIcon: profileIcon,
                      onTap: () {
                        context.toNext(const ProfileViewScreen());
                      }),
                  view.drawerListItemView(
                      title: SAVED_PLACES,
                      prefixIcon: savedPlacesIcon,
                      onTap: () {
                        context.toNext(const SavedPlacesScreen());
                      }),
                  view.drawerListItemView(
                      title: RIDE_HISTORIES,
                      prefixIcon: rideHistoryIcon,
                      onTap: () {
                        context.toNext(const RideHistoryScreen());
                      }),
                  view.drawerListItemView(
                      title: PAYMENTS,
                      prefixIcon: transactionsIcon,
                      onTap: () {
                        context.toNext(PaymentScreen());
                      }),
                  view.drawerListItemView(
                      title: NOTIFICATIONS,
                      prefixIcon: notificationIcon,
                      onTap: () {
                        context.toNext(const NotificationScreen());
                      }),
                  view.drawerListItemView(
                      title: TERM_CONDITIONS,
                      prefixIcon: termsAndPolicyIcon,
                      onTap: () {
                        context.toNext( TermsScreen(url: termConditionUrl,title: "Terms And Conditions",));
                      }),
                  view.drawerListItemView(
                      title: CONTACT_US,
                      prefixIcon: contactUsIcon,
                      onTap: () {
                        context.toNext(const ContactUsScreen());
                      }),
                  view.drawerListItemView(
                      title: ABOUTE_US,
                      prefixIcon: aboutUsIcon,
                      onTap: () {
                        context.toNext(const AboutUsScreen());
                      }),
                  view.drawerListItemView(
                      title: LOGOUT,
                      prefixIcon: switchOffOnIcon,
                      onTap: () {
                        view.showLogoutDialog();
                      }),
                  20.height,
                  view.drawerFooterView(_appInfoController,onShareTap: (){
                    ShareLinkHelper.shareLink(aboutUsUrl);
                  }),
                ],
              ),
            ),
          ),
        ),
        child: HomeScreen(
          controller: _advancedDrawerController,
        ));
  }
}
