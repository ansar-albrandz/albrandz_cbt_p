import 'package:albrandz_cbt_p/controllers/auth/auth_controller.dart';
import 'package:albrandz_cbt_p/controllers/auth/login_with_pin_controller.dart';
import 'package:albrandz_cbt_p/views/screens/login/login_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/login/login_with_pin_screen.dart';
import 'package:albrandz_cbt_p/views/screens/login/otp_verification_screen.dart';
import 'package:albrandz_cbt_p/views/utils/builders/loader_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileController = TextEditingController();
  var authController = Get.put(AuthController());
  var pinController = Get.put(LoginWithPinController());
  var loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var view = LoginWidgets(context: context);
    var width = context.fullWidth;
    var height = context.fullHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height*.52,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(loginImagePath),fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Form(
                key: loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    30.height,
                    view.titleView(LOGIN),
                    20.height,
                    view.mobileTextView(ENTER_MOBILE),
                    5.height,
                    view.mobileWithCountryCod4Field(mobileController,onSelected: (code){
                      setState(() {
                        countryCode = "+${code.phoneCode}";
                        countryFlag = code.flagEmoji;
                      });
                    }),
                    30.height,
                    ButtonWidgets().appButtonFillView(CONTINUE,onTap: (){
                      if(loginKey.currentState!.validate()){
                        getUserOTP();
                      }
                    },width: width),
                    20.height,
                    SizedBox(
                        width: width,
                        height: 25,
                        child: view.orLineView()),
                    20.height,
                    ButtonWidgets().appButtonFillOutView(LOGIN_WITH_PIN,onTap: (){
                      if(loginKey.currentState!.validate()){
                        verifyMobile();
                      }
                    },width: width),
                    // 20.height,
                  ],
                ),
              ),
            ),
            10.height
          ],
        ),
      ),
    );
  }

  String countryCode = INITAL_COUNTRY_CODE;
  String countryFlag = '🇮🇳';

  getUserOTP()async{
    final mobile = countryCode+mobileController.text.trim();
    LoaderBuilder(context: context).showFullScreenLoader();
    await authController.getOTP(mobile);
    if(!mounted) return;
    LoaderBuilder(context: context).dismissLoader();
    if(authController.otpSent.value){
      authController.countryCode.value = countryCode;
      authController.countryFlag.value = countryFlag;
      authController.mobileNumber.value = mobileController.text.trim();
      Get.to(const OtpVerificationScreen());
    }
  }

  verifyMobile()async{
    LoaderBuilder(context: context).showFullScreenLoader();
    await pinController.loginWithPin(countryCode+mobileController.text.trim());
    LoaderBuilder(context: context).dismissLoader();
    if(pinController.loginSuccess.value){
      authController.countryCode.value = countryCode;
      authController.countryFlag.value = countryFlag;
      authController.mobileNumber.value = mobileController.text.trim();
      Get.to(LoginWithPinScreen());
    }
  }
}
