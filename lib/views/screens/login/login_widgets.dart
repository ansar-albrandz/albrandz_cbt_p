import 'dart:async';

import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/decorations/app_widget_decorations.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/widget_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/borders/app_border_radius.dart';
import '../../utils/widgets/text_filed_widgets.dart';

class LoginWidgets {
  BuildContext context;

  LoginWidgets({required this.context});

  Widget titleView(String title) => Text(
        title,
        style: AppTextStyle.boldBlack(),
      );

  Widget mobileTextView(String title) => Text(
        title,
        style: AppTextStyle.semiBoldBlack(),
      );

  Widget mobileWithCountryCod4Field(TextEditingController controller,
      {required void Function(Country country) onSelected}) {

   return TextFiledWidgets().phoneWithCountryCOdeTextField(controller,onSelect: onSelected);
  }

  Widget otpFieldsView(TextEditingController pinController) {
    return Pinput(
      errorTextStyle: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: normalTextSize-2,color: errorBorderColor),
      focusedPinTheme: PinTheme(
          height: otpFieldHeight,
          width: otpFieldWidth,
          textStyle: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: boldTextSize),
          decoration: AppBoxDecoration.border(
              color: focusBorderColor, width: enableBorderWidth)),
      errorPinTheme: PinTheme(
          height: otpFieldHeight,
          width: otpFieldWidth,
          textStyle: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: boldTextSize,color: errorBorderColor),
          decoration: AppBoxDecoration.border(
              color: errorBorderColor, width: enableBorderWidth)),
      controller: pinController,
      length: 6,
      validator: (text) => text?.pinCodeValidator("OTP"),
      defaultPinTheme: PinTheme(
          textStyle: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: boldTextSize),
          height: otpFieldHeight,
          width: otpFieldWidth,
          decoration: BoxDecoration(
            color: fillInputColor,
            borderRadius: AppBorderRadius.all()
          )
      ),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  bool _passwordVisible = false;
  Widget pinTextFieldView(TextEditingController controller,
      {required IconData icon}) {
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return TextFormField(
        controller: controller,
        validator: (text) => text?.pinCodeValidator("PIN"),
        maxLength: 6,
        obscureText: !_passwordVisible,
        obscuringCharacter: "*",
        style: const TextStyle(letterSpacing: 3),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            counterText: "",
            filled: true,
            fillColor: fillInputColor,
            prefixIcon: Icon(
              icon,
              color: Colors.black54,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: _passwordVisible?primaryColor:Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )
        ),
      );
    },);
  }

  Widget orLineView() => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(
            height: 3,
            thickness: 1,
          ).expanded(),
          10.width,
          const Text(
            OR,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          10.width,
          const Divider(
            thickness: 1,
          ).expanded()
        ],
      );

  Widget rememberLoginView(bool value,{required void Function(bool?) onChanged}) {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Checkbox(
              side: const BorderSide(color: disableBorderColor,width: defaultBorderWidth),
              value: value, onChanged: onChanged),
        ),
        5.width,
        const Text(REMEMBER_LOGIN)
      ],
    );
  }
}

class ResendButtonView extends StatefulWidget {
  final void Function() onPressed;
  const ResendButtonView({super.key, required this.onPressed});

  @override
  State<ResendButtonView> createState() => _ResendButtonViewState();
}

class _ResendButtonViewState extends State<ResendButtonView> {
  int _remainingSeconds = resendOTPWaitingTime;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
            onTap: _canResend ? onResend : null,
            child: Text(
              "Resend",
              style: TextStyle(fontWeight: FontWeight.bold,color: _canResend?primaryColor:Colors.grey),
            )),
        5.width,
        Text(_canResend?"your OTP":"OTP ($_remainingSeconds seconds)")
      ],
    );
  }

  onResend() {
    widget.onPressed();
    _startTimer();
    print("Start timmer");
    _canResend = false;
    _remainingSeconds = resendOTPWaitingTime;
    setState(() {

    });
  }
}
