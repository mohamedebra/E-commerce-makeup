import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class Coustom_Activity extends StatelessWidget {
  const Coustom_Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){},

          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                Icon(CupertinoIcons.star),
                SizedBox(width: 10.w,),
                Text('Reviews',style: TextStyles.font18BlackMedium,),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
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
                const Icon(CupertinoIcons.chat_bubble_text_fill),
                SizedBox(width: 10.w,),
                Text('Questions & Answers',style: TextStyles.font18BlackMedium,),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
