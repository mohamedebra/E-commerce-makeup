
import 'package:dio/dio.dart';
import 'package:e_commerce_makeup/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/ui/home_view.dart';


class AppRouter{

  //  Route generateRoute(RouteSettings settings){
  //    final arguments = settings.arguments;
  //   switch(settings.name) {
  //
  //       case Routes.offerScreen:
  //       return MaterialPageRoute(
  //         builder: (_) => BlocProvider(
  //             create: (context) => OffersCubit(OfferRepo()),
  //             child:  Offers()),
  //       );
  //     case Routes.detailsProduct:
  //       return MaterialPageRoute(
  //         builder: (_) =>  DetailsProduct(productItems: arguments as ProductItems,),
  //       );
  //     case Routes.loginScreen:
  //       return MaterialPageRoute(
  //         builder: (_) => BlocProvider(
  //             create: (context) => getIt<LoginCubit>(),
  //             child:  LoginScreen())
  //       );
  //     case Routes.registerScreen:
  //       return MaterialPageRoute(
  //           builder: (_) => BlocProvider(
  //               create: (context) => getIt<RegisterCubit>(),
  //               child:  RegisterScreen())
  //       );
  //     case Routes.notificationScreen:
  //       return MaterialPageRoute(builder: (_) => const NotificationScreen());
  //     case Routes.homeScreen:
  //       return MaterialPageRoute(
  //         builder: (_) =>  HomeView(),
  //       );
  //
  //     default: return MaterialPageRoute(
  //         builder: (_) => Scaffold(
  //           body:  Center(child:
  //           Text('No Route default for ${settings.name}'),),
  //         )
  //     );
  //   }
  //
  // }
   Route? generateRoute(RouteSettings settings) {
     final arguments = settings.arguments;

     switch (settings.name) {





       case Routes.homeScreen:
         return MaterialPageRoute(
           builder: (_) =>  const HomeView(),
         );


     }
   }
}