import 'package:albrandz_cbt_p/views/screens/login/login_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/shared_preference_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Landing Screen",
              style: AppTextStyle.boldBlack(),
            ),
            Container(
              child: Text("Working on..."),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfileViewScreen()));
                },
                child: Text("Profile")),
            ElevatedButton(
                onPressed: () async{
                  await SharedPreferenceHelper().removeAll();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginScreen()), (_)=>false);
                },
                child: Text("LogOut"))
          ],
        ),
      ),
    );
  }
}
