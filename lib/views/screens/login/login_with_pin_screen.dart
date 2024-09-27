import 'package:albrandz_cbt_p/controllers/auth/auth_controller.dart';
import 'package:albrandz_cbt_p/controllers/auth/login_with_pin_controller.dart';
import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/views/screens/login/forget_pin_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_screen.dart';
import 'package:albrandz_cbt_p/views/utils/builders/loader_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/assets_path.dart';
import '../../utils/constants/constants.dart';
import '../../utils/widgets/app_image_view.dart';
import '../../utils/widgets/button_widgets.dart';
import 'login_widgets.dart';

class LoginWithPinScreen extends StatefulWidget {
  const LoginWithPinScreen({super.key});

  @override
  State<LoginWithPinScreen> createState() => _LoginWithPinScreenState();
}

class _LoginWithPinScreenState extends State<LoginWithPinScreen> {
  final pinKey = GlobalKey<FormState>();

  final _authController = Get.put(AuthController());

  final _pinController = Get.put(LoginWithPinController());

  TextEditingController pinController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var view = LoginWidgets(context: context);
    var height = context.fullHeight;
    var width = context.fullWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppImageView.screenBackgroundImageImage(
                path: verifyOTPImagePath, size: Size(width, height * .50)),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Form(
                key: pinKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.height,
                    view.titleView(VERIFY),
                    20.height,
                    view.mobileTextView(PIN_INPUT),
                    5.height,
                    view.pinTextFieldView(pinController, icon: Icons.lock_outlined),
                    20.height,
                    Row(
                      children: [
                        Expanded(
                            child: view.rememberLoginView(isChecked,
                                onChanged: (bool? value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        })),
                        TextButton(
                            onPressed: () {
                              forgetPin();
                            },
                            child: Text(
                              FORGET_PIN,
                              style: AppTextStyle.semiBoldBlack(),
                            ))
                      ],
                    ),
                    30.height,
                    ButtonWidgets().appButtonFillView(CONTINUE, onTap: () {
                      if (pinKey.currentState!.validate()) {
                        loginWithPin(context);
                      }
                    }, width: width),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginWithPin(BuildContext context) async {
    var mobile =
        '${_authController.countryCode.value}${_authController.mobileNumber.value}';
    var pin = pinController.text.trim();
    LoaderBuilder(context: context).showFullScreenLoader();
    await _pinController.verifyPin(mobile, pin);
    LoaderBuilder(context: context).dismissLoader();

    if (_pinController.verifySuccess.value) {
      if (isChecked) {
        UserLocalDataController().storeLogInStatus();
      } else {
        UserLocalDataController().storeLogInStatus(value: false);
      }
      context.toNextRemove(ProfileViewScreen());
    }
  }

  forgetPin() async {
    var mobile =
        '${_authController.countryCode.value}${_authController.mobileNumber.value}';
    LoaderBuilder(context: context).showFullScreenLoader();
    await _pinController.forgotPin(mobile);
    LoaderBuilder(context: context).dismissLoader();
    if (_pinController.forgetPinSuccess.value) {
      Get.to(ForgetPinScreen());
    }
  }
}
