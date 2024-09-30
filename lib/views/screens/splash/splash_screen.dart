import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/views/screens/home/drawer_screen.dart';
import 'package:albrandz_cbt_p/views/screens/intro/intro_screen.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash(){
    Future.delayed(const Duration(seconds: 3),()async{
      if(await UserLocalDataController().isLogIn()){
        context.toNextRemove(DrawerScreen());
      }else{
        context.toNext(const IntroScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppImageView.appLogoView(),
      ),
    );
  }
}
