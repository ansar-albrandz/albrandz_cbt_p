import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/views/screens/profile/profile_view_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileViewScreen extends StatelessWidget {
    ProfileViewScreen({super.key});

   var profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var view = ProfileViewWidgets(context: context);
    var height = context.fullHeight;
    var width = context.fullWidth;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Image.asset(
                profileImagePath,
                height: height,
                width: width,
                fit: BoxFit.fill,
              )),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(()=>Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  70.height,
                  view.profilePictureView(onTap: (){
                    view.showImageSelectionBottomSheet();
                  }),
                  view.userNameView(profileController.profileData.value.name??"NA"),
                  40.height,
                  view.infoFieldView(
                      title: profileController.profileData.value.name??"NA",
                      leadingIcon: profileNameIcon,
                      trailingButton: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(editProfileIcon))),
                  view.lineView(),
                  view.infoFieldView(
                      title: profileController.profileData.value.email??"NA", leadingIcon: emailIdIcon),
                  view.lineView(),
                  view.infoFieldView(title: profileController.profileData.value.dob??"NA", leadingIcon: dobIcon),
                  view.lineView(),
                  view.infoFieldView(title: profileController.profileData.value.gender??"NA", leadingIcon: genderIcon),
                  view.lineView(),
                  view.infoFieldView(
                      title: profileController.profileData.value.pin??"NA", leadingIcon: passwordPinIcon),
                  view.lineView(),
                  view.infoFieldView(
                      title: 'Add Card',
                      leadingIcon: creditCardIcon,
                      trailingButton: IconButton(
                          onPressed: () {},
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(addCardIcon),
                          ))),
                  view.lineView(),
                  40.height,
                  ButtonWidgets()
                      .appButtonFillView("Ok", width: width),
                  50.height
                ],
              ),)
            ),
          )
        ],
      ),
    );
  }
}
