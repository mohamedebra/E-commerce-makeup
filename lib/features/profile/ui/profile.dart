import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:e_commerce_makeup/core/theming/styles.dart';
import 'package:e_commerce_makeup/features/profile/ui/widget/coustom_activity.dart';
import 'package:e_commerce_makeup/features/profile/ui/widget/cousttom_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bachGroundScaffold,
      // appBar: AppBar(
      //   backgroundColor: ColorsManager.bachGroundScaffold,
      //   title:  Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Image(image: AssetImage('assets/icons/Error.png'),width: 35.w,),
      //       SizedBox(width: 5.w,),
      //       Text('E-commerce',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
      //       Spacer(),
      //       GestureDetector(
      //         onTap: (){},
      //         child:  Row(
      //           children: [
      //             Icon(Icons.output),
      //             Text('Logout')
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomRight,
                    stops: [
                      0,
                      .6,
                      1
                    ],
                    colors: [
                      Colors.white,
                      ColorsManager.bachGroundScaffold,
                      ColorsManager.mainMauve
                    ]),
              ),
              child:  Padding(
                padding:  EdgeInsets.only(top: 25.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: const AssetImage('assets/icons/Error.png'),width: 35.w,),
                    SizedBox(width: 5.w,),
                    const Text('E-commerce',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){},
                      child:  const Row(
                        children: [
                          Icon(Icons.output),
                          Text('Logout')
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/Error.png'),
                  ),
                  SizedBox(width: 15.w,),
                  Text('Hello,',style: TextStyles.font24BlackBold,)
                ],
              ),
              SizedBox(height: 45.h,),
              Text('Account Settings',style: TextStyles.font18BlackMedium,),
              const Cousttom_Setting(),
              SizedBox(height: 40.h,),
              Text('My Activity',style: TextStyles.font18BlackMedium,),
              SizedBox(height: 15.h,),
              const Coustom_Activity()
            ],),
          )
        ],
      ),

    );
  }
}
