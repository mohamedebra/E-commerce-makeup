import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/data/model/product_model.dart';

class ItemBottomNavBar extends StatefulWidget {
  const ItemBottomNavBar({super.key, required this.product});
  final Item product;

  @override
  State<ItemBottomNavBar> createState() => _ItemBottomNavBarState();
}

class _ItemBottomNavBarState extends State<ItemBottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 73,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 1,
          color: Colors.grey.withOpacity(0.5),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            "\$${widget.product.price}",
            style:  TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.mainMauve,
            ),
          ),
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorsManager.mainMauve)),
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.cart_badge_plus,
                color:  Colors.white,
              ),
              label: const Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 18,
                  color:  Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }



  void addToCart(context, product) {
    // CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    // product.pQuantity = _quantity;
    // bool exist = false;
    // var productsInCart = cartItem.products;
    // for (var productInCart in productsInCart) {
    //   if (productInCart.pName == product.pName) {
    //     exist = true;
    //   }
    // }
    // if (exist) {
    //   scffoldKey.currentState!.showBottomSheet((context) =>
    //       Text('you\'ve added this item before'),);
    // }
    // else {
    //   cartItem.addProduct(product);
    //   scffoldKey.currentState!.showBottomSheet((context) =>
    //       Text('Added to Cart'),);
    // } //Text('Added to Cart')
  }
}
