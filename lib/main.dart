import 'package:albrandz_cbt_p/views/screens/splash/splash_screen.dart';
import 'package:albrandz_cbt_p/views/utils/app_theme.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      theme: AppTheme().getAppTheme(),
      home:  SplashScreen(),
    );
  }
}
