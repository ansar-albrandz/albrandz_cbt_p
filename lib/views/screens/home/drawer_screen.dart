import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/views/screens/home/home_screen.dart';
import 'package:albrandz_cbt_p/views/screens/home/widgets/home_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/login/login_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../utils/constants/constants.dart';

class DrawerScreen extends StatelessWidget {
   DrawerScreen({super.key});

  final _advancedDrawerController = AdvancedDrawerController();

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
        ), drawer: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            view.drawerListItemView(title: PROFILE, prefixIcon: Icons.person,onTap: (){
              context.toNext(const ProfileViewScreen());
            }),
            view.drawerListItemView(title: SAVE_PLACES, prefixIcon: Icons.star),
            view.drawerListItemView(title: RIDE_HISTORIES, prefixIcon: Icons.history),
            view.drawerListItemView(title: PAYMENTS, prefixIcon: Icons.payment_outlined),
            view.drawerListItemView(title: NOTIFICATIONS, prefixIcon: Icons.notification_important),
            view.drawerListItemView(title: TERM_CONDITIONS, prefixIcon: Icons.edit_document),
            view.drawerListItemView(title: CONTACT_US, prefixIcon: Icons.contact_support),
            view.drawerListItemView(title: ABOUTE_US, prefixIcon: Icons.info),
            view.drawerListItemView(title: LOGOUT, prefixIcon: Icons.logout,onTap:()async{
              await UserLocalDataController().removeAll();
              context.toNextRemove(const LoginScreen());
            }),
            20.height,
            view.drawerFooterView(),
          ],
        ),
      ),
    ),
        child: HomeScreen(controller: _advancedDrawerController,));
  }
}
