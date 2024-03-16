import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../chat/ui/chat.dart';
import '../../../favourite/ui/favourite.dart';
import '../../../profile/ui/profile.dart';
import '../../../shopping/ui/shopping.dart';
import '../../data/model/product_model.dart';
import '../../ui/home_screen.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List screen = [
    const HomeScreen(),
    const Favourite(),
    const Shopping(),
    const ChatScreen(),
    const Profile(),

  ];

  int currentIndex = 0;
  List<Item> selectedProduct = [];
  List<Item> products = [];
  List<Item> productsFava = [];
  bool favorite = true;
  IconData iconData = Icons.favorite_border;

  double price = 0;
  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeNavBar());
  }


  add(Item product) {
    selectedProduct.add(product);
    emit(UpdateSelectedProduct());
    price += product.price.round();
    emit(UpdatePrice());
  }


  delete(Item product) {
    selectedProduct.remove(product);
    emit(UpdateSelectedProduct());
    price -= product.price.round();
    emit(UpdatePrice());
  }


  addProduct(Item product) {
    products.add(product);
    emit(AddProduct());
  }



  deleteProduct(Item product) {
    products.remove(product);
    emit(RemoveProduct());
  }

  void changeIconfavorite(Item product) {
    productsFava.add(product);
    favorite = !favorite;
    iconData = favorite ? Icons.favorite : Icons.favorite_border;

    emit(ChangeIconFavorie());
  }
}

