import 'package:e_commerce_makeup/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theming/colors.dart';
import '../../home/data/model/product_model.dart';
import '../../home/logic/home_logic/home_cubit.dart';
import '../../home/logic/home_logic/home_pro.dart';
import '../../home/logic/home_logic/home_state.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Item> products = Provider.of<CartItem>(context).productsFavorite;
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // var cubit = HomeCubit.get(context);

          return Scaffold(
            backgroundColor: ColorsManager.bachGroundScaffold,
            body: Column(
              children: [
                Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      gradient: const LinearGradient(
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
                            'Favourite',
                            style: TextStyle(fontSize: 25),
                          ),
                        ))),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Card(
                              child: Padding(
                                padding:  EdgeInsets.all(8.0.w),
                                child: SizedBox(
                                  height: 150.h,
                                  child: Row(
                                    children: [
                                      Image(
                                        image:
                                        AssetImage(cartItem.productsFavorite[index].imgPath),
                                        width: 100,
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                cartItem.productsFavorite[index].name,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(width: 110.w,),
                                              const Icon(
                                                Icons.favorite ,
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "\$${cartItem.productsFavorite[index].price}",
                                                style: TextStyle(fontSize: 17.sp),
                                              ),
                                              SizedBox(width: 20.w,),
                                              Icon(Icons.star,color: Colors.orange,size: 18.w,),
                                              SizedBox(width: 3.w,),
                                              Text("(2K Review)",style: TextStyle(fontSize: 12.sp,color: Colors.grey),)

                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(onPressed: (){
                                                 cartItem.deleteProductFavorite(cartItem.productsFavorite[index]);
                                              }, child: const Text("Remove to Wishlist", style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red
                                                ),
                                              )),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 3.h),
                              child: Container(
                                decoration:  BoxDecoration(
                                  color: Colors.black,

                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.w),topLeft: Radius.circular(20.w)),
                                ),
                                width: 50,
                                height: 50,
                                child: IconButton(onPressed: (){},icon: Icon(CupertinoIcons.shopping_cart,color: Colors.white,size: 20.w,),),
                              ),
                            )

                          ],
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}
