import 'package:albrandz_cbt_p/models/profile/create_profile_model.dart';
import 'package:albrandz_cbt_p/models/profile/profile_response_model.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
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

  @override
  onInit() {
    super.onInit();
    // getProfile();
  }

  Future<void> getProfile() async {
    try {
      final response = await _apiController.get(getProfileEndPoint,isHeader: true);
      var data = ProfileResponseModel.fromJson(response);
      if (response != null && data.response?.status == 'success') {
        profileData.value = data.body?.personal ?? ProfilePersonalData();
        isProfileLoading(true);
        isLoading(true);
      } else {
        isProfileLoading(false);
        isLoading(false);
        Get.snackbar(
            'Error', data.response?.message ?? 'Failed to fetch profile');
      }
    } catch (error) {
      isProfileLoading(false);
      isLoading(false);
      Get.snackbar('Error', 'An error occurred: $error');
    }
  }

  Future<void> createProfile(CreateProfileModel profileDetails) async {
    isLoading(true);
    try {
      final response = await _apiController.post(createProfileEndPoint,
          data: profileDetails.toJson(), isHeader: true);
      if (response != null && response['response']['status'] == 'success') {
        isProfileCreated(true);
        Get.snackbar('Success', 'Profile created successfully');
      } else {
        isProfileCreated(false);
        Get.snackbar('Error',
            response['response']['message'] ?? 'Failed to create profile');
      }
    } catch (error) {
      isProfileCreated(false);
      Get.snackbar('Error', 'An error occurred: $error');
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
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        isProfileUpdated(false);
        Get.snackbar('Error',
            response['response']['message'] ?? 'Failed to update profile');
      }
    } catch (error) {
      isProfileUpdated(false);
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading(false);
    }
  }
}
