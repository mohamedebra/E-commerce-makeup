import 'package:e_commerce_makeup/core/network/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'features/my_app.dart';

void main() async{
  Stripe.publishableKey = ApiConstants.publishablekey;
  // await Stripe.instance.applySettings();

  runApp(const MyApp());
}


