import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../builders/app_country_code_builder.dart';

class TextFiledWidgets {
  Widget appTextFieldView(TextEditingController controller,
      {String? hintText,
      required String prefixIcon,
      String? suffixIcon,
      String? Function(String?)? validator,
      void Function(String)? onChanged,
      TextInputType keyBordTYpe = TextInputType.text,
      void Function()? onTap,
      bool enabled = true,
      bool readOnly = false,
      int? maxLength,
      String counterText = ""}) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyBordTYpe,
      style: AppTextStyle.normalBlack(),
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: fillInputColor,
          counterText: counterText,
          prefixIcon: _assetImage(prefixIcon),
          contentPadding: EdgeInsets.zero),
    );
  }

  Widget _assetImage(String path) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(path),
      );

  Widget phoneWithCountryCOdeTextField(TextEditingController controller,
      {bool canSelect = true,
      required void Function(Country) onSelect,
      bool isEnabled = true,CountryData? country}) {
    return TextFormField(
      maxLength: 10,
      enabled: isEnabled,
      controller: controller,
      validator: (no) => no?.phoneValidator(),
      style: const TextStyle(letterSpacing: 2),
      decoration: InputDecoration(
        filled: true,
        counterText: "",
        contentPadding: EdgeInsets.zero,
          fillColor: fillInputColor,
          prefixIcon: SizedBox(
        height: 45,
        width: 120,
        child: Row(
          children: [
            CountryCodeBuilder(
              country: country,
              canSelect: canSelect,
              onSelect: onSelect,
            ),
            const VerticalDivider()
          ],
        ),
      )),
    );
  }
}
