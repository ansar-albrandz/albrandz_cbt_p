import 'dart:io';

import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/controllers/profile/take_image_controller.dart';
import 'package:albrandz_cbt_p/views/screens/profile/create_profile_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/widgets/profile_view_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/builders/loader_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileViewScreen extends StatefulWidget {
    const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
   var profileController = Get.put(ProfileController());
   var takeImageController = Get.put(TakeImageController());

   @override
  void initState() {
    super.initState();
    init();
  }

  init()async{
    await profileController.getProfilePicture();
    await profileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var view = ProfileViewWidgets(context: context);
    var height = context.fullHeight;
    var width = context.fullWidth;
    return Obx(()=>profileController.isLoading.value == true?Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(profileImagePath),fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
              child: Obx(()=>Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  70.height,
                  InkWell(
                    onTap: (){
                      print("Profile picture clicked");
                    },
                    child: view.profilePictureView(onTap: (){
                      view.showImageSelectionBottomSheet();
                    }),
                  ),
                  view.userNameView(profileController.profileData.value.name??"NA"),
                  40.height,
                  view.infoFieldView(
                      title: profileController.profileData.value.name??"NA",
                      leadingIcon: profileNameIcon,
                      trailingButton: IconButton(
                          onPressed: () {
                            Get.to(CreateProfileScreen(isNew: false,));
                          },
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
                      title: ADD_CARD,
                      leadingIcon: creditCardIcon,
                      trailingButton: IconButton(
                          onPressed: () {},
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(addCardIcon),
                          ))),
                  view.lineView(),
                  40.height,
                  takeImageController.selectedImagePath.value.isEmpty?ButtonWidgets()
                      .appButtonFillView(OK, width: width):ButtonWidgets()
                      .appButtonFillView(UPLOAD, width: width,onTap: ()async{
                        LoaderBuilder(context: context).showFullScreenLoader();
                        await profileController.updateProfilePicture(File(takeImageController.selectedImagePath.value));
                        LoaderBuilder(context: context).dismissLoader();
                        if(profileController.uploadImageStatus.value){
                          print("Image uploaded");
                        }
                  }),
                  50.height
                ],
              ),)
          ),
        ),
      ),
    ):const FullScreenLoaderView(path: null));
  }
}
