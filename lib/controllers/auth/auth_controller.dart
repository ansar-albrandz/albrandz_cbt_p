import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/models/auth/otp_response_model.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:get/get.dart';

import '../api/api_controller.dart';

class AuthController extends GetxController {

  final ApiController _apiController = ApiController();

  var countryCode = "".obs;
  var countryFlag = "".obs;
  var mobileNumber = "".obs;

  // State variables
  var isLoading = false.obs;
  var otpSent = false.obs;
  var isLoggedOut = false.obs;
  var isOTPVerified = false.obs;
  var isOTPResend = false.obs;

  Future<void> getOTP(String phoneNumber) async {
    isLoading(true);
    try {
      final response = await _apiController.post(
        getOTPEndPoint,
        data: {'mobile': phoneNumber},
      );
      if (response != null && response['response']['status'] == 'success') {
        otpSent(true);
        Get.snackbar('Success', 'OTP sent successfully');
      } else {
        otpSent(false);
        Get.snackbar('Error', "Your mobile number is invalid");
      }
    } catch (error) {
      otpSent(false);
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOTP(String phoneNumber, String otp) async {
    isLoading(true);
    try {
      final response = await _apiController.post(
        verifyOTPEndPoint,
        data: {
          'mobile': phoneNumber,
          'otp': otp,
        },
      );
      var data = OtpResponseModel.fromJson(response);
      if (response != null && data.response?.status == 'success') {
        isOTPVerified(true);
        var token = response['header'];
        await UserLocalDataController().storeLoginToken(token);
        Get.snackbar('Success', 'OTP verified successfully');
      } else {
        isOTPVerified(false);
        Get.snackbar('Error', data.response?.message ?? 'Invalid OTP');
      }
      isLoading(false);
    } catch (error) {
      isLoading(false);
      isOTPVerified(false);
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> resendOTP(String phoneNumber) async {
    isLoading(true);
    try {
      final response = await _apiController.put(
        resendOTPEndPoint,
        data: {'mobile': phoneNumber},
      );
      if (response != null && response['response']['status'] == 'success') {
        isOTPResend(true);
        Get.snackbar('Success', 'OTP resent successfully');
      } else {
        isOTPResend(false);
        Get.snackbar('Error', response['response']['message'] ?? 'Failed to resend OTP');
      }
    } catch (error) {
      isOTPResend(false);
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading(false);
    }
  }

  // Method to log out
  Future<void> logout() async {
    isLoading(true);
    try {
      final response = await _apiController.get(logoutEndPoint);
      if (response != null && response['response']['status'] == 'success') {
        isLoggedOut(true);
        Get.snackbar('Success', 'Logged out successfully');
      } else {
        isLoggedOut(false);
        Get.snackbar('Error', response['response']['message'] ?? 'Failed to log out');
      }
    } catch (error) {
      isLoggedOut(false);
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading(false);
    }
  }
}
