import 'package:albrandz_cbt_p/views/screens/intro/intro_screen.dart';
import 'package:albrandz_cbt_p/views/utils/app_theme.dart';
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
      title: 'Cabo Cab',
      theme: AppTheme().getAppTheme(),
      home:  IntroScreen(),
    );
  }
}
