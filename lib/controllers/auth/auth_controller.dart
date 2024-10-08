import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/models/auth/otp_response_model.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:get/get.dart';

import '../api/api_controller.dart';

class AuthController extends GetxController {

  final ApiController _apiController = ApiController();

  var countryCode = "".obs;
  var countryFlag = "".obs;
  var mobileNumber = "".obs;

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
      } else {
        otpSent(false);
      }
    } catch (error) {
      otpSent(false);
      (error.toString()).showToast();
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
      } else {
        isOTPVerified(false);
        data.response?.message?.showToast();
      }
      isLoading(false);
    } catch (error) {
      isLoading(false);
      isOTPVerified(false);
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
      } else {
        isOTPResend(false);
      }
    } catch (error) {
      isOTPResend(false);
    } finally {
      isLoading(false);
    }
  }

  // Method to log out
  Future<void> logout() async {
    try {
      final response = await _apiController.get(logoutEndPoint,isHeader: true);
      if (response != null && response['response']['status'] == 'success') {
        isLoggedOut(true);
      } else {
        isLoggedOut(false);
      }
    } catch (error) {
      isLoggedOut(false);
    }
  }
}
