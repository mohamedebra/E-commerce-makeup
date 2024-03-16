import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/model.dart';
import '../../logic/chat_cubit.dart';
import '../../logic/chat_state.dart';

class ChatDr1 extends StatefulWidget {
  const ChatDr1({super.key, required this.model});
  final SocialModel model;

  @override
  State<ChatDr1> createState() => _ChatDr1State();
}

class _ChatDr1State extends State<ChatDr1> {

  final TextEditingController _numberCtrl = TextEditingController();

  @override
  void initState() {
    _numberCtrl.text = "01015613089";
    super.initState();
  }

  // MessageModel model = MessageModel();
  var messageContror = TextEditingController();

  final controller = ScrollController();

  var massageControlar = TextEditingController();
  // final docRef = FirebaseFirestore.instance.collection("users").doc();
  // var mag = FirebaseFirestore.instance.collection('messages').doc('id');

//   static String topItms = 'EN';
//
//   static List<String> itemList = ['EN', 'AR', 'FR'];
// // Remove the 'capital' field from the document
//   final updates = <String, dynamic>{
//     "capital": FieldValue.delete(),
//   };
  List<MessageModel> messageList = [];
  MessageModel messageModel = MessageModel();
  @override
  Widget build(BuildContext context) {
    _callNumber() async {
      const number = '01015613089'; //set the number here
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    }
    List<MessageModel> message = [];
    for (var i = 0; i <messageList.length; i++) {
      message.add(MessageModel.fromJson(messageList[i].toJson()));
    }
    return BlocProvider(
      create: (BuildContext context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          var uId = widget.model.uId;
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundImage: AssetImage(widget.model.image!)),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    '${widget.model.name}',
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        reverse: true,
                        controller: controller,
                        itemBuilder: (context, index) {
                          return message[index].receiverId == uId
                              ? buildmessage(message[index])
                              : buildyourmessage(message[index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                        itemCount: message.length),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black26,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: TextFormField(
                              controller: messageContror,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...'),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.blue[300],
                          child: MaterialButton(
                            onPressed: () {

                              sendMessages(
                                dataTime: DateTime.now().toString(),
                                text: messageContror.text,
                                receiverId: '1',
                                senderId: SocialModel().uId,
                              );
                              // sendMessages(dataTime: '');
                              messageContror.clear();
                              controller.animateTo(0,
                                  // controller.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            },
                            child: Icon(Icons.send),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void sendMessages({
    required String? dataTime,
    required String? text,
    required String? receiverId,
    required String? senderId,
  })async {
    MessageModel model1 = MessageModel(
        text: text,
        dateTime: dataTime,
        receiverId: receiverId,
        senderId: senderId
    );
//set my chats
    messageList.add(model1);
    setState(() {

    });
    //      .then((value) {
    //       print(value);
    //     }).catchError((error) {
    //       print(error.toString());
    //     });
  }
  Widget buildmessage(MessageModel message) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.grey[300]),
      child: Text('${message.text}'),
    ),
  );
  Widget buildyourmessage(MessageModel message) => InkWell(
    onTap: () {
      // AppCubit.get(context).deletemag();
    },
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
            color: Colors.blue[100]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${message.text}'),
        ),
      ),
    ),
  );


  Widget buildChats(SocialModel model, BuildContext context) => Row(
    children: [
      CircleAvatar(
        radius: 17,
        backgroundImage: NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/medical-371515.appspot.com/o/WhatsApp%20Image%202023-04-19%20at%202.23.09%20AM.jpeg?alt=media&token=668dfc5a-0809-489b-9ab5-7dbdfb3b1748'),
      ),
      SizedBox(
        width: 6,
      ),
      Text(
        'Dr, Mohamed ebrahim',
        style: TextStyle(fontSize: 15),
      )
    ],
  );
}