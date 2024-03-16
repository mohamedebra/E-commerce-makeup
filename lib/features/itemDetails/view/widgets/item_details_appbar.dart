import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home/logic/home_logic/home_pro.dart';


class ItemDetailsAppBar extends StatelessWidget {
  const ItemDetailsAppBar({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20,right: 15,left: 15),
      child: Row(children: [
        IconButton(
            onPressed: () {
              // AppFunctions.popNavigate(context: context);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: ColorsManager.mainMauve,
              size: 40,
            )),
        const SizedBox(width: 20),
        const Text(
          "Product",
          style: TextStyle(
              fontSize: 23,
              color: ColorsManager.mainMauve,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // This assumes your Product model has a `name` attribute
            addToFov(context, item);
          },
          icon: Consumer<CartItem>(
            builder: (context, cartItem, child) {
              // Change the condition to check if product is favored
              bool isFavored = cartItem.isProductFavorite(item.name);
              return Icon(
                isFavored ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              );
            },
          ),
        )
      ]),
    );
  }
  void addToFov(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    // product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.productsFavorite;
    for (var productInCart in productsInCart) {
      if (productInCart.name == product.name) {
        exist = true;
      }
    }
    if (exist) {
      cartItem.removeProductFavorite(product);

    }
    else {
      cartItem.addProductFavorite(product);

    } //Text('Added to Cart')
  }

}
