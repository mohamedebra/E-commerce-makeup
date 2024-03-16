
import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../chat/data/model/model.dart';

class CartItem extends ChangeNotifier {
  List<Item> products = [];
  List<Item> productsFavorite = [];
  int price = 0;
  bool favorite = true;
  IconData iconData = Icons.favorite_border;
  List<MessageModel> messageList = [];
  int quantity = 1;


  addProduct(Item product) {
    products.add(product);
    price += product.price.round();

    notifyListeners();
  }

  deleteProduct(Item product) {
    products.remove(product);
    price -= product.price.round();

    notifyListeners();
  }

  addProductFavorite(Item product) {
    productsFavorite.add(product);
    notifyListeners();
  }

  deleteProductFavorite(Item product) {
    productsFavorite.remove(product);
    notifyListeners();
  }
  void changeIconFavorite(Item product) {
    productsFavorite.add(product);
    favorite = !favorite;
    notifyListeners();

    iconData = favorite ? Icons.favorite : Icons.favorite_border;

    notifyListeners();
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
    notifyListeners();

    //      .then((value) {
    //       print(value);
    //     }).catchError((error) {
    //       print(error.toString());
    //     });
  }
  deleteMassage(MessageModel massage) {
    messageList.remove(massage);
    notifyListeners();
  }

  bool isProductFavorite(String productName) {
    return productsFavorite.any((product) => product.name == productName);
  }
  void removeProductFavorite(Item product) {
    productsFavorite.removeWhere((p) => p.name == product.name);
    notifyListeners();
  }

  remove() {
    if (quantity > 0) {
      quantity --;
    }
    notifyListeners();

  }

  add() {
    quantity ++;
    notifyListeners();
  }
}
