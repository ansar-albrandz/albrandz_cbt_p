import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/take_image_service.dart';

class TakeImageController extends GetxController {
  var selectedImagePath = ''.obs;
  final TakeImageService _picker = TakeImageService();

  Future<void> pickImageFromCamera(BuildContext context) async {
    final XFile? pickedImage = await _picker.takeImageFromCamera(context);
    if (pickedImage != null) {
      selectedImagePath.value = pickedImage.path;
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final XFile? pickedImage = await _picker.takeImageFromGallery(context);
    if (pickedImage != null) {
      selectedImagePath.value = pickedImage.path;
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }
}
