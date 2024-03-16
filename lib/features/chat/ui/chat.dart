import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:e_commerce_makeup/features/chat/data/model/model.dart';
import 'package:e_commerce_makeup/features/chat/ui/widget/chat_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bachGroundScaffold,
      // appBar: AppBar(
      //   backgroundColor: ColorsManager.mainMauve,
      //   title: Text('Chat',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
      //   centerTitle: true,
      // ),
      body: ConditionalBuilder(
        condition: alluser != null,
        builder: (BuildContext context) {
          return Column(
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
                  child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          'Chat',
                          style: TextStyle(fontSize: 25),
                        ),
                      ))),

              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        buildChats(alluser[index], context),
                    separatorBuilder: (context, index) => Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: alluser.length),
              ),

            ],
          );
        },
        fallback: (BuildContext context) => const CircularProgressIndicator(),
      ),
    );
  }
  Widget buildChats(SocialModel model, BuildContext context) => InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatDr1(model: model,)));
    },
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.w,
            backgroundImage: AssetImage('${model.image}'),
          ),
          SizedBox(
            width: 15.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                '${model.email}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    ),
  );

}
