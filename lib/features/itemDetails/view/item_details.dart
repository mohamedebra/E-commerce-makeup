import 'package:clippy_flutter/arc.dart';
import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:e_commerce_makeup/features/home/logic/home_logic/home_cubit.dart';
import 'package:e_commerce_makeup/features/home/logic/home_logic/home_state.dart';
import 'package:e_commerce_makeup/features/itemDetails/view/widgets/item_bottom_navbar.dart';
import 'package:e_commerce_makeup/features/itemDetails/view/widgets/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home/data/model/product_model.dart';
import '../../home/logic/home_logic/home_pro.dart';
import 'widgets/item_details_appbar.dart';

// ignore: must_be_immutable
class ItemDetails extends StatefulWidget {

  ItemDetails({super.key, required this.product});
  final Item product;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  List<Color> clrs = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.orange,
  ];
  int _quantity = 1;
  var scffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit,HomeState>(
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            key: scffoldKey,
            backgroundColor: ColorsManager
                .secondaryColor,
            body: Column(
              children: [
                 ItemDetailsAppBar(item: widget.product,),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(widget.product.imgPath, height: 280)),
                // flutter-clippy
                Arc(
                  edge: Edge.TOP,
                  arcType: ArcType.CONVEY,
                  height: 30,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 40),
                          child: Row(
                            children: [
                              Text(
                                widget.product.name,
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: ColorsManager.mainMauve,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProductRatingWidget(productId: widget.product.id, item: widget.product,),
                                Row(
                                  children: [
                                    // plus
                                    ClipOval(
                                      child: Material(
                                        color: ColorsManager.bachGroundScaffold,
                                        child: GestureDetector(
                                          onTap: remove,
                                          child: SizedBox(
                                            child: Icon(CupertinoIcons.arrow_down_circle,size: 18,),
                                            height: 25,
                                            width: 25,),

                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child:  Text(
                                          "$_quantity",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color:ColorsManager.mainMauve,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    // mins
                                    ClipOval(
                                      child: Material(
                                        color: ColorsManager.bachGroundScaffold,

                                        child: GestureDetector(
                                          onTap: add,
                                          child: SizedBox(
                                            child: Icon(CupertinoIcons.arrow_up_circle,size: 18,),
                                            height: 25,
                                            width: 25,),

                                        ),
                                      ),
                                    )

                                  ],
                                ),

                              ],
                            )),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            "This is more detailed sescription about the product. you can write here more about the the product. this is lengthy description.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                              color: ColorsManager.mainMauve,
                            ),
                          ),
                        ),

                      ]),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar:  Container(
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
                      onPressed: () {
                        addToCart(context,widget.product);
                      },
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
            ),
          );
        },
      ),
    );
  }

  remove() {
    if (_quantity > 0)
      setState(() {
        _quantity --;
      });
  }

  add() {
    setState(() {
      _quantity ++;
    });
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
      scffoldKey.currentState!.showBottomSheet((context) =>
          Text('you\'ve added this item before'),);
    }
    else {
      cartItem.addProduct(product);
      scffoldKey.currentState!.showBottomSheet((context) =>
          Text('Added to Cart'),);
    } //Text('Added to Cart')
  }

}
