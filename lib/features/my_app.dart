import 'package:e_commerce_makeup/features/home/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'auth/login/ui/login_screen.dart';
import 'home/logic/home_logic/home_pro.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<CartItem>(
            create: (context) => CartItem(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MakeUp",
          home: LoginScreen(),
        ),
      ),
    );
  }
}
