import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theming/colors.dart';
import '../../../itemDetails/view/item_details.dart';
import '../../data/model/product_model.dart';
import '../../logic/home_logic/home_cubit.dart';
import '../../logic/home_logic/home_pro.dart';
import '../../logic/home_logic/home_state.dart';

class ItemsWidgets extends StatefulWidget {
   const ItemsWidgets({super.key, required this.scffoldKey});
final GlobalKey<ScaffoldState> scffoldKey;

  @override
  State<ItemsWidgets> createState() => _ItemsWidgetsState();
}

class _ItemsWidgetsState extends State<ItemsWidgets> {
  int _quantity = 1;

  bool icon = true;

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Container(
                        //   padding: const EdgeInsets.all(5),
                        //   decoration: BoxDecoration(
                        //       color: ColorsManager.mainMauve,
                        //       borderRadius: BorderRadius.circular(20)),
                        //   child: const Text(
                        //     "",
                        //     style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        IconButton(
                          onPressed: () {
                            // This assumes your Product model has a `name` attribute
                            addToFov(context, items[index]);
                          },
                          icon: Consumer<CartItem>(
                            builder: (context, cartItem, child) {
                              // Change the condition to check if product is favored
                              bool isFavored = cartItem.isProductFavorite(items[index].name);
                              return Icon(
                                isFavored ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetails(
                                  product: items[index],
                               )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          items[index].imgPath,
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        items[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: ColorsManager.mainMauve),
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "write description of product",
                        style: TextStyle(
                            fontSize: 13, color: ColorsManager.mainMauve),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$ ${items[index].price}",
                              style: const TextStyle(
                                  color: ColorsManager.mainMauve,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  addToCart(context ,items[index],);
                                  // product.pQuantity = _quantity;

                                },
                                icon: const Icon(
                                  Icons.shopping_cart_checkout,
                                  color: ColorsManager.mainMauve,
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.name == product.name) {
        exist = true;
      }
    }
    if (exist) {

    }
    else {
      cartItem.addProduct(product);
    } //Text('Added to Cart')
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
