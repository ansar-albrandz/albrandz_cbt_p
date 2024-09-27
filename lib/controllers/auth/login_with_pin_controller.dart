import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:get/get.dart';

import '../api/api_controller.dart';
import '../data/user_local_data_controller.dart';

class LoginWithPinController extends GetxController {
  final ApiController _apiController = ApiController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var loginSuccess = false.obs;
  var verifySuccess = false.obs;
  var resentPinSuccess = false.obs;
  var forgetPinSuccess = false.obs;

  // Method to login with PIN
  Future<void> loginWithPin(String mobile) async {
    isLoading(true);
    errorMessage.value = '';
    loginSuccess(false);

    try {
      final response = await _apiController.post(
        loginPINEndPoint,
        data: {'mobile': mobile},
      );

      if (response != null && response['response']['status'] == 'success') {
        loginSuccess(true);
        Get.snackbar('Success', 'Login successful');
      } else {
        errorMessage.value = response['response']['message'] ?? 'Login failed';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (error) {
      errorMessage.value = 'An error occurred: $error';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyPin(String mobile, String pin) async {
    isLoading(true);
    errorMessage.value = '';
    verifySuccess(false);

    try {
      final response = await _apiController.post(
        verifyPINEndPoint,
        data: {'mobile': mobile,'pin':pin},
      );

      if (response != null && response['response']['status'] == 'success') {
        verifySuccess(true);
        var token = response['header'];
        await UserLocalDataController().storeLoginToken(token);
        Get.snackbar('Success', 'Login successful');
      } else {
        verifySuccess(false);
        errorMessage.value = response['response']['message'] ?? 'Login failed';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (error) {
      verifySuccess(false);
      errorMessage.value = 'An error occurred: $error';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Method to resend PIN
  Future<void> resendPin(String mobile, String otp) async {
    isLoading(true);
    errorMessage.value = '';
    resentPinSuccess(false);

    try {
      final response = await _apiController.put(
        resendPINEndPoint,
        data: {'mobile': mobile, 'otp': otp},
      );

      if (response != null && response['response']['status'] == 'success') {
        resentPinSuccess(true);
        Get.snackbar('Success', 'PIN resent successfully');
      } else {
        errorMessage.value = response['response']['message'] ?? 'Resending PIN failed';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (error) {
      errorMessage.value = 'An error occurred: $error';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Method to reset/forget PIN
  Future<void> forgotPin(String mobile) async {
    isLoading(true);
    errorMessage.value = '';
    forgetPinSuccess(false);

    try {
      final response = await _apiController.post(
        forgetPINEndPoint,
        data: {'mobile': mobile},
      );

      if (response != null && response['response']['status'] == 'success') {
        forgetPinSuccess(true);
        Get.snackbar('Success', 'PIN reset instructions sent');
      } else {
        errorMessage.value = response['response']['message'] ?? 'PIN reset failed';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (error) {
      errorMessage.value = 'An error occurred: $error';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Method to resent PIN after setting a new one
  Future<void> resentPin(String mobile, String otp, String newPin) async {
    isLoading(true);
    errorMessage.value = '';
    resentPinSuccess(false);

    try {
      final response = await _apiController.post(
        resetPINEndPoint,
        data: {'mobile': mobile, 'otp': otp, 'pin': newPin},
      );

      if (response != null && response['response']['status'] == 'success') {
        resentPinSuccess(true);
        Get.snackbar('Success', 'PIN resent successfully with new PIN');
      } else {
        errorMessage.value = response['response']['message'] ?? 'Resending new PIN failed';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (error) {
      errorMessage.value = 'An error occurred: $error';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
