import 'package:albrandz_cbt_p/views/utils/builders/app_country_code_builder.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/text_filed_widgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileWidgets {
  BuildContext context;

  ProfileWidgets({required this.context});

  Widget titleView(String title) => Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      );

  Widget fieldTitleTextView(String title) => Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54),
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

  Widget appDropDownView(List<String> items,
      {required void Function(dynamic)? onChanged, String? hintText}) {
    return SizedBox(
      height: 48,
      child: DropdownButtonFormField(
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey.shade200,
              filled: true,
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
                  print("Privacy Policy tapped");
                },
            ),
          ],
        ),
      );

  Widget _assetImage(String path) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(path),
      );
}
