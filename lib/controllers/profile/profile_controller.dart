import 'dart:io';

import 'package:albrandz_cbt_p/models/profile/create_profile_model.dart';
import 'package:albrandz_cbt_p/models/profile/profile_model.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:get/get.dart';
import '../api/api_controller.dart';

class ProfileController extends GetxController {
  final ApiController _apiController =
      ApiController();

  var isLoading = false.obs;
  var profileData = ProfilePersonalData().obs;
  var isProfileCreated = false.obs;
  var isProfileUpdated = false.obs;
  var isProfileLoading = false.obs;


  Future<void> getProfile() async {
    try {
      final response = await _apiController.get(getProfileEndPoint,isHeader: true);
      var data = ProfileModel.fromJson(response);
      if (response != null && data.response?.status == 'success') {
        profileData.value = data.body?.personal ?? ProfilePersonalData();
        isProfileLoading(true);
        isLoading(true);
      } else {
        isProfileLoading(false);
        isLoading(false);
        (response['response']['message']).toString().showToast();
      }
    } catch (error) {
      isProfileLoading(false);
      isLoading(false);
    }
  }

  Future<void> createProfile(CreateProfileModel profileDetails) async {
    isLoading(true);
    try {
      final response = await _apiController.post(createProfileEndPoint,
          data: profileDetails.toJson(), isHeader: true);
      if (response != null && response['response']['status'] == 'success') {
        isProfileCreated(true);
        (response['response']['message']).toString().showToast();
      } else {
        isProfileCreated(false);

      }
    } catch (error) {
      isProfileCreated(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> profileDetails) async {
    isLoading(true);
    try {
      final response = await _apiController.put(
        updateProfileEndPoint,
        data: profileDetails,
      );
      if (response != null && response['response']['status'] == 'success') {
        profileData.value = response['response']['data'];
        isProfileUpdated(true);
        (response['response']['message']).toString().showToast();
      } else {
        isProfileUpdated(false);
      }
    } catch (error) {
      isProfileUpdated(false);
    } finally {
      isLoading(false);
    }
  }

  var getImageStatus = false.obs;
  var imageUri = ''.obs;

  Future<void> getProfilePicture() async {
    try {
      final response = await _apiController.get(
        getProfilePictureEndPoint,
        isHeader: true,
      );
      if (response != null && response['response']['status'] == 'success') {
        getImageStatus(true);
        imageUri.value = response['body']['photo']['file'];
        (response['response']['message']).toString().showToast();
      } else {
        getImageStatus(false);
      }
    } catch (error) {
      getImageStatus(false);
    }
  }

  var uploadImageStatus = false.obs;

  Future<void> uploadProfilePicture(File file) async {
    try {
      final response = await _apiController.uploadFile(
        uploadProfilePictureEndPoint,
        file,
        isHeader: true,
      );
      if (response != null && response['response']['status'] == 'success') {
        uploadImageStatus(true);
        Get.snackbar('Success', 'Image uploaded successfully');
      } else {
        uploadImageStatus(false);
        Get.snackbar('Error',
            response['response']['message'] ?? 'Failed to upload profile image');
      }
    } catch (error) {
      uploadImageStatus(false);
      Get.snackbar('Error', 'An error occurred: $error');
    }
  }

  var updateImageStatus = false.obs;

  Future<void> updateProfilePicture(File file) async {
    try {
      final response = await _apiController.updateFile(
        uploadProfilePictureEndPoint,
        file,
        isHeader: true,
      );
      if (response != null && response['response']['status'] == 'success') {
        updateImageStatus(true);
        (response['response']['message']).toString().showToast();
      } else {
        updateImageStatus(false);
      }
    } catch (error) {
      updateImageStatus(false);
    }
  }
}
