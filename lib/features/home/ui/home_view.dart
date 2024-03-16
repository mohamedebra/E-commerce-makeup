import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theming/colors.dart';
import '../logic/home_logic/home_cubit.dart';
import '../logic/home_logic/home_state.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
              extendBody: true,
              // backgroundColor: background,
              body: cubit.screen[cubit.currentIndex],
              bottomNavigationBar: CurvedNavigationBar(
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                height: 50,
                backgroundColor: Colors.transparent,
                color: ColorsManager.mainMauve,
                items: const [
                  Icon(Icons.home, size: 30, color: Colors.white),
                  Icon(Icons.favorite_border, size: 30, color: Colors.white),
                  Icon(CupertinoIcons.cart_fill, size: 30, color: Colors.white),
                  Icon(CupertinoIcons.chat_bubble_2, size: 30, color: Colors.white),
                  Icon(CupertinoIcons.person, size: 30, color: Colors.white),
                ],
              ),

            );
          },
        ));
  }
}
