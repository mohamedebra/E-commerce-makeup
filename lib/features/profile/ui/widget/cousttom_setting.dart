import 'package:e_commerce_makeup/features/profile/ui/widget/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class Cousttom_Setting extends StatelessWidget {
  const Cousttom_Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfile()));

          },
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                const Icon(CupertinoIcons.person),
                SizedBox(width: 10.w,),
                Text('Edit Profile',style: TextStyles.font18BlackMedium,),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){

          },
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                const Icon(CupertinoIcons.creditcard),
                SizedBox(width: 10.w,),
                Text('Saved Cards & Wallet',style: TextStyles.font18BlackMedium,),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                const Icon(CupertinoIcons.location_solid),
                SizedBox(width: 10.w,),
                Text('Saved Addresses',style: TextStyles.font18BlackMedium,),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){},

          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                const Icon(Icons.language),
                SizedBox(width: 10.w,),
                Text('Select Language',style: TextStyles.font18BlackMedium,),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                const Icon(CupertinoIcons.bell),
                SizedBox(width: 10.w,),
                Text('Notifications Settings',style: TextStyles.font18BlackMedium,),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
