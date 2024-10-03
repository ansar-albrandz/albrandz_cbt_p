import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../builders/app_country_code_builder.dart';
import 'app_image_view.dart';

class TextFiledWidgets {
  Widget appTextFieldView(TextEditingController controller,
      {String? hintText,
      required String prefixIcon,
      IconData? suffixIcon,
      String? Function(String?)? validator,
      void Function(String)? onChanged,
      TextInputType keyBordTYpe = TextInputType.text,
      void Function()? onTap,
      bool enabled = true,
      bool readOnly = false,
      int? maxLength,
      String counterText = "",void Function()? onSuffixTap}) {
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
          suffixIcon: InkWell(
            onTap: onSuffixTap,
              child: Icon(suffixIcon)),
          counterText: counterText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: AppImageView().assetSVGImageView(prefixIcon,),
          ),
          contentPadding: EdgeInsets.zero),
    );
  }

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
