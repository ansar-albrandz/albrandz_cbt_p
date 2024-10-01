import 'package:albrandz_cbt_p/controllers/auth/auth_controller.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/text_filed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/app/app_info_controller.dart';
import '../../../../controllers/data/user_local_data_controller.dart';
import '../../../utils/constants/assets_path.dart';
import '../../../utils/constants/constants.dart';
import '../../login/login_screen.dart';

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

  Widget drawerFooterView(AppInfoController controller,{void Function()? onShareTap}) {

    return Padding(
      padding: const EdgeInsets.all(horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onShareTap,
            child: Row(
              children: [
                AppImageView().assetSVGImageView(shareIcon,color: Colors.white),
                Text(
                  SHARE,
                  style: AppTextStyle.normalWhite(),
                ),
              ],
            ),
          ),
          Obx(()=>Text(
            '$APP_VERSION - ${controller.appVersion.value}',
            style: AppTextStyle.normalWhite(),
          )),
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
            child: Image.asset(
              imagePath,
              height: 60,
              width: 120,
            ),
          ),
        ),
        Text(
          title,
          style: AppTextStyle.boldBlack(textSize: 14),
        ),
      ],
    );
  }

  showLogoutDialog(){
    showDialog(context: context, builder: (_)=>AlertDialog(
      title: const Text("$LOGOUT!"),
      content: const Text(LOGOUT_MESSAGE),
      actions: [
        TextButton(onPressed: ()async{
          await AuthController().logout().then((_)async{
            await UserLocalDataController().removeAll();
            context.toNextRemove(const LoginScreen());
          });
        }, child: const Text(YES)),
        TextButton(onPressed: (){
          context.onBackPressed;
        }, child: const Text(NO)),
      ],
    ));
  }
}
