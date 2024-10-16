import 'package:albrandz_cbt_p/controllers/auth/auth_controller.dart';
import 'package:albrandz_cbt_p/controllers/services/ride_map_controller.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
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
      required String prefixIcon,
      IconData trailingIcon = Icons.arrow_right_outlined,
      void Function()? onTap,Color color = Colors.white}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
            leading: AppImageView().assetSVGImageView(prefixIcon,color: color),
            trailing: Icon(trailingIcon, color: color, size: appIconSize),
            title: Text(
              title,
              style: color == Colors.white?AppTextStyle.normalWhite():AppTextStyle.normalBlack(),
            ),
            onTap: onTap),
        const Divider(
          thickness: .2,
          indent: 15,
          endIndent: 25,
          height: 1,
        )
      ],
    );
  }

  Widget searchView({void Function(String)? onChanged,void Function()? onSuffixTap}) {
    var mapController = Get.put(RideMapController());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.all()
      ),
      child: Obx(()=>TextFiledWidgets().appTextFieldView(mapController.searchPickupController.value,
          prefixIcon: searchIcon,
          onChanged: onChanged,
          hintText: "Where to go...",
          onSuffixTap: onSuffixTap,
          suffixIcon: Icons.arrow_forward)),
    );
  }

  Widget drawerFooterView(AppInfoController controller,{void Function()? onShareTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onShareTap,
            child: Row(
              children: [
                AppImageView().assetSVGImageView(shareIcon,color: Colors.white,size: 25),
                10.width,
                Text(
                  SHARE,
                  style: AppTextStyle.normalWhite(textSize: semiBoldTextSize),
                ),
              ],
            ),
          ),
          Obx(()=>Text(
            '$APP_VERSION - ${controller.appVersion.value}',
            style: AppTextStyle.normalWhite(textSize: semiBoldTextSize),
          )),
        ],
      ),
    );
  }

  Widget suggestionTitleView()=>Text(SUGGESTIONS,style: AppTextStyle.boldBlack(textSize: boldTextSize-2),);

  Widget suggestionItemView({required String title, required String imagePath}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.white,
            elevation: 5,
            child: Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Center(child: cardView(imagePath)),
        )),
        5.height,
        Text(
          title,
          style: AppTextStyle.boldBlack(textSize: boldTextSize-4),
        ),
      ],
    );
  }

  Widget cardView(String imagePath){
    return Image.asset(imagePath,height: 60,
      width: 100,);
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
