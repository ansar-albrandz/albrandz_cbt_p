import 'dart:io';

import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/take_image_controller.dart';
import '../../utils/constants/constants.dart';

class ProfileViewWidgets {
  BuildContext context;

  ProfileViewWidgets({required this.context});

  profilePictureView({void Function()? onTap}) {
    final takeImageController = Get.put(TakeImageController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(50)),
            child: Obx((){
              var image = takeImageController.selectedImagePath.value;
              return image != ''?ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(File(image),fit: BoxFit.cover,color: Colors.black54,),
              ):const Icon(Icons.person_outline,size: 80,);
            }),
          ),
          InkWell(
            onTap: onTap,
            child: const CircleAvatar(
              backgroundColor: primaryColor,
              child: Icon(
                Icons.camera_alt_outlined,
                color: primaryIconColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  _circleImageView(String image){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.file(File(image),fit: BoxFit.cover,color: Colors.black54,),
    );
  }

  Widget userNameView(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget infoFieldView(
      {required String title,
      required String leadingIcon,
      IconButton? trailingButton}) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: _assetImage(leadingIcon),
        title: Text(
          title,
          style: AppTextStyle.semiBoldBlack(textSize: 16),
        ),
        trailing: trailingButton);
  }

  Widget _assetImage(String path) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(path),
      );

  Widget lineView() => const Divider(
        thickness: 1,
        endIndent: 10,
        indent: 10,
      );

  showImageSelectionBottomSheet() {
    final takeImageController = Get.put(TakeImageController());
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              height: context.fullHeight / 5,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Select Source",
                      style: AppTextStyle.boldBlack(),
                    ),
                  ),
                  const Divider(),
                  Flexible(
                      child: _imageSelectionItemView(
                          title: CAMERA, icon: Icons.camera_alt_outlined,onTap: (){
                        takeImageController.pickImageFromCamera(context);
                        context.onBackPressed;
                      })),
                  Flexible(
                      child: _imageSelectionItemView(
                          title: GALLERY, icon: Icons.photo,onTap: (){
                        takeImageController.pickImageFromGallery(context);
                        context.onBackPressed;
                      })),
                ],
              ),
            ));
  }

  _imageSelectionItemView(
      {required String title, required IconData icon, void Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
    );
  }
}
