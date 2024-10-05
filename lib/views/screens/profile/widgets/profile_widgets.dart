import 'package:albrandz_cbt_p/views/screens/term/terms_screen.dart';
import 'package:albrandz_cbt_p/views/utils/builders/app_country_code_builder.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/webview_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/text_filed_widgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfileWidgets {
  BuildContext context;

  ProfileWidgets({required this.context});

  Widget titleView(String title) => Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      );

  Widget fieldTitleTextView(String title) => Text(
        title,
        style: AppTextStyle.semiBoldBlack(),
      );
  Widget mobileWithCountryCod4Field(TextEditingController controller,
      {CountryData? country}) {
    return TextFiledWidgets().phoneWithCountryCOdeTextField(controller,
        onSelect: (Country country) {}, canSelect: false, isEnabled: false,country: country);
  }

  Widget textFieldView(TextEditingController controller,
      {required String icon,
      String? Function(String?)? validator,
      TextInputType keyBoard = TextInputType.number,
      int? maxLength,
      bool onlyRead = false,
      void Function()? onTap}) {
    return TextFiledWidgets().appTextFieldView(controller,
        validator: validator, prefixIcon: icon, maxLength: maxLength,readOnly: onlyRead,onTap: onTap);
  }

  Widget appDropDownView(String item,
      {required void Function(dynamic)? onChanged, String? hintText}) {
    var items = ["Male", "Female"];
    return SizedBox(
      height: 48,
      child: DropdownButtonFormField(
        value: item,
          style: AppTextStyle.normalBlack(),
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey.shade200,
              filled: true,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: AppImageView().assetSVGImageView(genderIcon),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusSize),
                borderSide: BorderSide.none,
              )),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged),
    );
  }

  bool checked = false;
  Widget policyCheckboxView({required void Function(bool?) onChanged, required bool value}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                  value: value,
                  side: const BorderSide(color: disableBorderColor,width: defaultBorderWidth),
                  onChanged: onChanged),
            ),
            10.width,
            Expanded(child: checkBoxTitleView())
          ],
        );
      },
    );
  }

  Widget checkBoxTitleView() => RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black54),
          children: [
            const TextSpan(text: 'I have reviewed and agree to the '),
            TextSpan(
              text: 'Terms of Use',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: primaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                context.toNext( TermsScreen(title: "Terms And Condition",url: termConditionUrl,));
                  print("Terms of Use tapped");
                },
            ),
            const TextSpan(text: ' & acknowledge the '),
            TextSpan(
              text: 'Privacy Policy',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: primaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.toNext( TermsScreen(title: "Privacy Policy",url: policyUrl,));
                  print("Privacy Policy tapped");
                },
            ),
          ],
        ),
      );
}
