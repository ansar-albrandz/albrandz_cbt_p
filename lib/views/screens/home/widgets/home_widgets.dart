import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/text_filed_widgets.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/assets_path.dart';
import '../../../utils/constants/constants.dart';

class HomeWidgets {
  BuildContext context;
  HomeWidgets({required this.context});

  Widget drawerListItemView(
      {required String title,
      required IconData prefixIcon,
      IconData trailingIcon = Icons.arrow_forward_ios_sharp,
      void Function()? onTap,Color color = Colors.white}) {
    return Column(
      children: [
        ListTile(
            leading: Icon(prefixIcon, color: color),
            trailing: Icon(trailingIcon, color: color, size: 15),
            title: Text(
              title,
              style: color == Colors.white?AppTextStyle.normalWhite():AppTextStyle.normalBlack(),
            ),
            onTap: onTap),
        const Divider(
          thickness: .5,
          indent: 15,
          endIndent: 25,
          height: 1,
        )
      ],
    );
  }

  Widget searchView({void Function(String)? onChanged,void Function()? onSuffixTap}) {
    return TextFiledWidgets().appTextFieldView(TextEditingController(),
        prefixIcon: searchIcon,
        onChanged: onChanged,
        hintText: "Where to go...",
        onSuffixTap: onSuffixTap,
        suffixIcon: Icons.arrow_forward);
  }

  Widget drawerFooterView() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.share, color: Colors.white),
              SizedBox(width: 5),
              Text(
                SHARE,
                style: AppTextStyle.normalWhite(),
              ),
            ],
          ),
          Text(
            '$APP_VERSION - 1.45',
            style: AppTextStyle.normalWhite(),
          ),
        ],
      ),
    );
  }

  Widget suggestionTitleView()=>Text("Suggestions",style: AppTextStyle.boldBlack(),);

  Widget suggestionItemView({required String title, required String imagePath}){
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.all()
          ),
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(verticalPadding),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(normalRadiusSize),
                child: Image.asset(
                  imagePath,
                )),
          ),
        ),
        Text(
          title,
          style: AppTextStyle.boldBlack(textSize: 14),
        ),
      ],
    );
  }
}
