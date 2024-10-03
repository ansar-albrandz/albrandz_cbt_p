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
  var mobileNumber = ''.obs;


  Future<void> getProfile() async {
    try {
      final response = await _apiController.get(getProfileEndPoint,isHeader: true);
      var data = ProfileModel.fromJson(response);
      if (response != null && data.response?.status == 'success') {
        profileData.value = data.body?.personal ?? ProfilePersonalData();
        mobileNumber.value = data.body?.mobile??"NA";
        if(data.body?.personal?.name?.isEmpty == true){
          isProfileLoading(false);
        }else{
          isProfileLoading(true);
        }

        isLoading(true);
      } else {
        isProfileLoading(false);
        isLoading(false);
        (response['response']['message']).toString().showToast();
      }
    } catch (error) {
      isLoading(false);
      isProfileLoading(false);
    }
  }

  Future<void> createProfile(ProfilePersonalData profileDetails) async {
    isLoading(true);
    try {
      final response = await _apiController.post(createProfileEndPoint,
          data: profileDetails.toJson(), isHeader: true);
      if (response != null && response['response']['status'] == 'success') {
        isProfileCreated(true);
        (response['response']['message']).toString().showToast();
      } else {
        isProfileCreated(false);
        (response['response']['message']).toString().showToast();
      }
    } catch (error) {
      isProfileCreated(false);
    }
  }

  Future<void> updateProfile(ProfilePersonalData profileDetails) async {
    try {
      final response = await _apiController.put(
        updateProfileEndPoint,
        data: profileDetails.toJson(),
        isHeader: true
      );
      if (response != null && response['response']['status'] == 'success') {
        isProfileUpdated(true);
        profileData.value = profileDetails;

        (response['response']['message']).toString().showToast();
      } else {
        isProfileUpdated(false);
        (response['response']['message']).toString().showToast();
      }
    } catch (error) {
      print(error);
      isProfileUpdated(false);
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

        String file = response['body']['photo']['file'];
        if(file.isNotEmpty){
          imageUri.value = file;
          getImageStatus(true);
        }else{
          getImageStatus(false);
        }

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
        'Image uploaded successfully'.showToast();
      } else {
        uploadImageStatus(false);
        (response['response']['message']).toString().showToast();
      }
    } catch (error) {
      uploadImageStatus(false);
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
