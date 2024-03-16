import 'package:dio/dio.dart';
import 'package:e_commerce_makeup/core/network/api_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManagerTest {
  static Future<void> makePayment(int amount, String currency) async {
    try {
      String clientSecret = await _getClientSecret((amount * 100).toString(), currency);
      print("Client Secret: $clientSecret"); // Debugging
      await _initPayment(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      print("Payment Error: $error");
      throw Exception("Payment Error: $error");
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': "Bearer ${ApiConstants.secretkey}",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    print("Client secret fetched: ${response.data['client_secret']}");
    return response.data["client_secret"];
  }

  static Future<void> _initPayment(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Mohamed",
        ),
      );
      print("Payment sheet initialized successfully");
    } catch (e) {
      print("Failed to initialize payment sheet: $e");
      throw Exception("Failed to initialize payment sheet: $e");
    }
  }
}