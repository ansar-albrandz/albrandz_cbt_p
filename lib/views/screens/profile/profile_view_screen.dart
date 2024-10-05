import 'dart:io';

import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/controllers/profile/take_image_controller.dart';
import 'package:albrandz_cbt_p/views/screens/card/add_card_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/create_profile_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/widgets/profile_view_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/builders/loader_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  var profileController = Get.put(ProfileController());
  var takeImageController = Get.put(TakeImageController());
  bool isShowingPin = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await profileController.getProfilePicture();
    await profileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var view = ProfileViewWidgets(context: context);
    var height = context.fullHeight;
    var width = context.fullWidth;
    return Obx(() => profileController.isLoading.value == true
        ? Scaffold(
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(profileImagePath), fit: BoxFit.fill),
              ),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          70.height,
                          InkWell(
                            onTap: () {
                              print("Profile picture clicked");
                            },
                            child: view.profilePictureView(onTap: () {
                              view.showImageSelectionBottomSheet();
                            }),
                          ),
                          view.userNameView(
                              profileController.profileData.value.name ?? "NA"),
                          40.height,
                          view.infoFieldView(
                              title: profileController.mobileNumber.value,
                              leadingIcon: callIcon,
                              trailingButton: IconButton(
                                  onPressed: () {
                                    Get.to(const CreateProfileScreen(
                                        isNew: false));
                                  },
                                  icon: AppImageView().assetSVGImageView(editProfileIcon))),
                          view.lineView(),
                          view.infoFieldView(
                              title: profileController
                                          .profileData.value.email !=
                                      ""
                                  ? profileController.profileData.value.email ??
                                      "NA"
                                  : "NA",
                              leadingIcon: emailIdIcon),
                          view.lineView(),
                          view.infoFieldView(
                              title: profileController.profileData.value.dob !=
                                      ""
                                  ? profileController.profileData.value.dob ??
                                      "NA"
                                  : "NA",
                              leadingIcon: dobIcon),
                          view.lineView(),
                          view.infoFieldView(
                              title:
                                  profileController.profileData.value.gender !=
                                          ""
                                      ? profileController
                                              .profileData.value.gender ??
                                          "NA"
                                      : "NA",
                              leadingIcon: genderIcon),
                          view.lineView(),
                          view.infoFieldView(
                              title: isShowingPin
                                  ? profileController.profileData.value.pin ??
                                      "NA"
                                  : "* * * * * *",
                              leadingIcon: passwordPinIcon,
                              trailingButton: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isShowingPin = !isShowingPin;
                                    });
                                  },
                                  icon: Icon(isShowingPin
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,size: 22,))),
                          view.lineView(),
                          Column(
                            children: List.generate(1, (index) {
                              return Column(
                                children: [
                                  view.infoFieldView(
                                      title: "1234567890123456".replaceItems(
                                          items: 12,
                                          replace: "#### #### #### ")+"   City Bank",
                                      leadingIcon: creditCardIcon,
                                      trailingButton: IconButton(
                                          onPressed: () {
                                            AppDialogHelper().showCustomDialog(context, onPressed: (){}, title: "Remove Card!", message: "Do you want remove the card?");
                                          },
                                          icon: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                                CupertinoIcons.delete_simple,size: 20),
                                          ))),
                                  view.lineView()
                                ],
                              );
                            }),
                          ),
                          view.infoFieldView(
                              title: ADD_CARD,
                              leadingIcon: creditCardIcon,
                              trailingButton: IconButton(
                                  onPressed: () {
                                    context.toNext(AddCardScreen());
                                  },
                                  icon: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.add),
                                  ))),
                          view.lineView(),
                          40.height,
                          takeImageController.selectedImagePath.value.isEmpty
                              ? ButtonWidgets().appButtonFillView(OK,
                                  width: width, onTap: () {
                                  context.onBackPressed;
                                })
                              : ButtonWidgets().appButtonFillView(UPLOAD,
                                  width: width, onTap: () async {
                                  LoaderBuilder(context: context)
                                      .showFullScreenLoader();
                                  if (profileController.imageUri.isNotEmpty) {
                                    await profileController
                                        .updateProfilePicture(File(
                                            takeImageController
                                                .selectedImagePath.value));
                                  } else {
                                    await profileController
                                        .uploadProfilePicture(File(
                                            takeImageController
                                                .selectedImagePath.value));
                                  }
                                  LoaderBuilder(context: context)
                                      .dismissLoader();
                                  // if(profileController.uploadImageStatus.value || profileController.updateImageStatus.value){
                                  //   context.onBackPressed;
                                  // }
                                }),
                          50.height
                        ],
                      ),
                    )),
              ),
            ),
          )
        : const FullScreenLoaderView(path: null));
  }
}
