import 'dart:convert';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentController extends GetxController {
  var paymentIntent = Rxn<Map<String, dynamic>>(); // Observable payment intent

  @override
  void onInit() {

    super.onInit();
  }

  Future<void> makePayment({required String amount, required String currency}) async {
    try {
      paymentIntent.value = await createPaymentIntent(amount, currency); // Create payment intent

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.value!['client_secret'],
          googlePay: PaymentSheetGooglePay(
            testEnv: true,
            currencyCode: currency,
            merchantCountryCode: "IN",
            // buttonType: PlatformButtonType.
          ),
          merchantDisplayName: 'Cab Cab',
        ),
      );

      await displayPaymentSheet(); // Display the payment sheet
    } catch (e) {
      print("Exception: $e");
      paymentFailure("An error occurred while making the payment.");
    }
  }

  // Display the payment sheet
  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      onPaymentSuccess((){});// Call success handler on completion
    } on StripeException catch (e) {
      print('Stripe Error: $e');
      paymentFailure("Payment was cancelled.");
    } catch (e) {
      print("Error displaying payment sheet: $e");
      paymentFailure("An unexpected error occurred.");
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      final body = {
        'amount': (int.parse(amount) * 100).toString(), // Convert to smallest currency unit
        'currency': currency,
        'payment_method_types[]': 'card',
      };


      // Make the POST request using Dio
      final response = await Dio().post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      print('Payment Intent Response: ${response.data}');
      return response.data;
    } catch (err) {
      print('Error creating payment intent: ${err.toString()}');
      return null; // Return null on failure
    }
  }

  // Future<Map<String, dynamic>> createPaymentIntent(
  //     String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': (int.parse(amount) * 100).toString(), // Convert to smallest currency unit
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //     };
  //
  //     var response = await Dio().post(
  //       'https://api.stripe.com/v1/payment_intents',
  //       options: Options(headers: {
  //         'Authorization': 'Bearer $stripeSecretKey',
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       }),
  //       data: body,
  //     );
  //
  //     print('Payment Intent Response: ${response.data}');
  //     return jsonDecode(response.data);
  //   } catch (err) {
  //     print('Error creating payment intent: ${err.toString()}');
  //     rethrow;
  //   }
  // }

  void paymentSuccess() {
    Get.snackbar(
      "Payment Success",
      "Your payment was completed successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    paymentIntent.value = null; // Clear payment intent
  }

  onPaymentSuccess(void Function() onSuccess){
    onSuccess;
  }

  void paymentFailure(String message) {
    Get.snackbar(
      "Payment Failed",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    paymentIntent.value = null; // Clear payment intent
  }
}
