import 'package:albrandz_cbt_p/controllers/auth/login_with_pin_controller.dart';
import 'package:albrandz_cbt_p/views/screens/login/login_with_pin_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../utils/builders/loader_builder.dart';
import '../../utils/constants/assets_path.dart';
import '../../utils/constants/constants.dart';
import '../../utils/widgets/app_image_view.dart';
import '../../utils/widgets/button_widgets.dart';
import 'login_widgets.dart';

class ForgetPinScreen extends StatefulWidget {
  const ForgetPinScreen({super.key});

  @override
  State<ForgetPinScreen> createState() => _ForgetPinScreenState();
}

class _ForgetPinScreenState extends State<ForgetPinScreen> {
  final otpController = TextEditingController();
  final _authController = Get.put(AuthController());
  var forgetKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  final _pinController = Get.put(LoginWithPinController());

  @override
  Widget build(BuildContext context) {
    var view = LoginWidgets(context: context);
    var width = context.fullWidth;
    var height = context.fullHeight;
    var replacedMobile = "${_authController.countryCode.value}-"+ _authController.mobileNumber.value.replaceItems(8);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AppImageView.screenBackgroundImageImage(path: verifyOTPImagePath, size: Size(width, height * .50)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
                  child: Form(
                    key: forgetKey,
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
                        10.height,
                        ResendButtonView(
                          onPressed: (){
                            onResendPressed();
                          },
                        ),
                        20.height,
                        view.mobileTextView(NEW_PIN_TITLE),
                        5.height,
                        view.pinTextFieldView(pinController, icon: Icons.lock_outlined),
                        30.height,
                        ButtonWidgets().appButtonFillView(CONTINUE, onTap: () {
                          if(forgetKey.currentState!.validate()){
                            resetPin(context);
                          }
                          // _validateNumber(context);
                        }, width: width),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
    await _pinController.resendPin(
        _authController.countryCode.value + _authController.mobileNumber.value);
    LoaderBuilder(context: context).dismissLoader();
  }

  resetPin(BuildContext context) async {
    LoaderBuilder(context: context).showFullScreenLoader();
    await _pinController.resentPin(
        _authController.countryCode.value + _authController.mobileNumber.value,
        otpController.text.trim(),pinController.text.trim());
    LoaderBuilder(context: context).dismissLoader();
    if (_pinController.resentPinSuccess.value) {
      context.toNextRemove(LoginWithPinScreen());
    }
  }
}
