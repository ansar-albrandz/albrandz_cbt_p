import 'package:albrandz_cbt_p/controllers/auth/auth_controller.dart';
import 'package:albrandz_cbt_p/views/screens/profile/create_profile_screen.dart';
import 'package:albrandz_cbt_p/views/utils/builders/loader_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/constants.dart';
import '../../utils/widgets/button_widgets.dart';
import 'login_widgets.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otpController = TextEditingController();
  final _authController = Get.put(AuthController());
  var otpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var view = LoginWidgets(context: context);
    var width = context.fullWidth;
    var height = context.fullHeight;
    var replacedMobile = "${_authController.countryCode.value} "+ _authController.mobileNumber.value.replaceItems(8);

    return Scaffold(
      body: Stack(
        children: [
          AppImageView.backGroundAssetImage(
              path: verifyOTPImagePath,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    key: otpKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.height,
                        view.titleView(VERIFY),
                        20.height,
                        view.mobileTextView(
                            "Enter the 6 digit OTP sent to you at $replacedMobile"),
                        5.height,
                        view.otpFieldsView(otpController),
                        30.height,
                        ButtonWidgets().appButtonFillView(CONTINUE, onTap: () {
                          if(otpKey.currentState!.validate()){
                            verifyOTP(context);
                          }
                          // _validateNumber(context);
                        }, width: width),
                        30.height,
                        ResendButtonView(
                          onPressed: (){
                            onResendPressed();
                          },
                        ),
                        50.height,
                      ],
                    ),
                  ),
                ),
              ),
              size: Size(width, height * .52)),
          Positioned(
            top: 20,
            left: 20,
            child: ButtonWidgets().backButton(),
          ),
        ],
      ),
    );
  }

  onResendPressed() async {
    setState(() {});
    otpController.clear();
    LoaderBuilder(context: context).showFullScreenLoader();
    await _authController.resendOTP(
        _authController.countryCode.value + _authController.mobileNumber.value);
    LoaderBuilder(context: context).dismissLoader();
    if (_authController.isOTPResend.value) {}
  }

  verifyOTP(BuildContext context) async {
    LoaderBuilder(context: context).showFullScreenLoader();
    await _authController.verifyOTP(
        _authController.countryCode.value + _authController.mobileNumber.value,
        otpController.text.trim());
    LoaderBuilder(context: context).dismissLoader();
    if (_authController.isOTPVerified.value) {
      Get.to(const CreateProfileScreen());
    }
  }
}
