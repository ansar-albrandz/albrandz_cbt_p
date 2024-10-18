import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentController {

  final Function() onSuccess;
  final Function() onFailure;

  StripePaymentController({required this.onSuccess, required this.onFailure});

  Map<String, dynamic>? _paymentIntent;

  Future<void> makePayment({required String amount, required String currency}) async {
    try {
      _paymentIntent = await createPaymentIntent(amount, currency); // Create payment intent

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: _paymentIntent!['client_secret'],
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
      onFailure();
    }
  }

  // Display the payment sheet
  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      onSuccess();
    } on StripeException catch (e) {
      print('Stripe Error: $e');
      onFailure();
    } catch (e) {
      print("Error displaying payment sheet: $e");
      onSuccess();
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
}
