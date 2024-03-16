class SocialModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? password;

  SocialModel({this.name, this.email, this.phone, this.uId, this.password,this.image});

  SocialModel.fromjson(json) {
    email = json['email'];
    uId = json['uId'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'password': password,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
class MessageModel {
  final String? text;
  final String? dateTime;
  final String? receiverId;
  final String? senderId;

  MessageModel({this.text, this.dateTime, this.receiverId, this.senderId});

  // If you have a method like fromJson, ensure it correctly initializes all fields.
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] as String?,
      dateTime: json['dateTime'] as String?,
      receiverId: json['receiverId'] as String?,
      senderId: json['senderId'] as String?,
    );
  }

  // If you need to convert MessageModel instances back to a map, for example, to send them to an API:
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
    };
  }
}
List<SocialModel> alluser = [
  SocialModel(name: 'Mohamed',uId: '1',password: '123456',email: 'mohamed@gmail.com',phone: '123456',image: 'assets/images/1.png'),
  SocialModel(name: 'Ahmed',uId: '1',password: '1234567',email: 'Ahmed@gmail.com',phone: '123456',image: 'assets/images/2.png'),
  SocialModel(name: 'Mahmoud',uId: '1',password: '12345678',email: 'Mahmoud@gmail.com',phone: '123456',image: 'assets/images/3.png'),
];
List<MessageModel> massagesList = [

];
