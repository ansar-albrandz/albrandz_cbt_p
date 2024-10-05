
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/text_filed_widgets.dart';
import 'package:flutter/material.dart';

class CardWidgets {
  BuildContext context;

  CardWidgets({required this.context});

  Widget titleView(String title) => Text(
    title,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  );

  Widget fieldTitleTextView(String title,{bool isRequired = true}) => Text.rich(TextSpan(
      text: title,children: [
    isRequired?TextSpan(text: "*",style: AppTextStyle.semiBoldBlack(color: Colors.red)):TextSpan(),
  ],
      style: AppTextStyle.semiBoldBlack()
  ),);

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

  Widget appDropDownView(String icon,String? item,
      {required void Function(dynamic)? onChanged, String? hintText}) {
    var items = ["Male", "Female"];
    return SizedBox(
      // height: 48,
      child: DropdownButtonFormField(
          value: item,
          validator: (text)=>text?.isEmpty == true?"This field is required":text == null?"This field is required":null,
          style: AppTextStyle.normalBlack(),
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey.shade200,
              filled: true,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: AppImageView().assetSVGImageView(icon),
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
}