import 'package:albrandz_cbt_p/controllers/app/app_info_controller.dart';
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
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/share_link_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../utils/constants/constants.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final _advancedDrawerController = AdvancedDrawerController();
  final _appInfoController = Get.put(AppInfoController());

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
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                view.drawerListItemView(
                    title: PROFILE,
                    prefixIcon: Icons.person,
                    onTap: () {
                      context.toNext(const ProfileViewScreen());
                    }),
                view.drawerListItemView(
                    title: SAVE_PLACES,
                    prefixIcon: Icons.star,
                    onTap: () {
                      context.toNext(const SavedPlacesScreen());
                    }),
                view.drawerListItemView(
                    title: RIDE_HISTORIES,
                    prefixIcon: Icons.history,
                    onTap: () {
                      context.toNext(const RideHistoryScreen());
                    }),
                view.drawerListItemView(
                    title: PAYMENTS,
                    prefixIcon: Icons.payment_outlined,
                    onTap: () {
                      context.toNext(PaymentScreen());
                    }),
                view.drawerListItemView(
                    title: NOTIFICATIONS,
                    prefixIcon: Icons.notification_important,
                    onTap: () {
                      context.toNext(const NotificationScreen());
                    }),
                view.drawerListItemView(
                    title: TERM_CONDITIONS,
                    prefixIcon: Icons.edit_document,
                    onTap: () {
                      context.toNext(const TermsScreen());
                    }),
                view.drawerListItemView(
                    title: CONTACT_US,
                    prefixIcon: Icons.contact_support,
                    onTap: () {
                      context.toNext(const ContactUsScreen());
                    }),
                view.drawerListItemView(
                    title: ABOUTE_US,
                    prefixIcon: Icons.info,
                    onTap: () {
                      context.toNext(const AboutUsScreen());
                    }),
                view.drawerListItemView(
                    title: LOGOUT,
                    prefixIcon: Icons.logout,
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
        child: HomeScreen(
          controller: _advancedDrawerController,
        ));
  }
}
