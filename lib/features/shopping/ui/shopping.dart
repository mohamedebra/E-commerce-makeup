import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:e_commerce_makeup/features/home/logic/home_logic/home_cubit.dart';
import 'package:e_commerce_makeup/features/home/logic/home_logic/home_state.dart';
import 'package:e_commerce_makeup/features/shopping/ui/widget/cart_bottom_navbar.dart';
import 'package:e_commerce_makeup/features/shopping/ui/widget/payment.dart';
import 'package:e_commerce_makeup/features/shopping/ui/widget/paypal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theming/styles.dart';
import '../../home/logic/home_logic/home_pro.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  var scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List<Item> products = Provider.of<CartItem>(context).products;
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // var cubit = HomeCubit.get(context);

          return Scaffold(
            backgroundColor: ColorsManager.bachGroundScaffold,
            key: scaffold,
            body: Column(
              children: [
                Expanded(
                  child: Column(
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
                              'My Cart',
                              style: TextStyle(fontSize: 25),
                            ),
                          ))),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(products[index].name),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 130,
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                products[index].imgPath),
                                            width: 100,
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                products[index].name,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "\$${products[index].price}",
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Text(
                                                  "${cartItem.quantity}",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(left: 40,top: 70),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //     children: [
                                          //       // plus
                                          //       ClipOval(
                                          //         child: Material(
                                          //           color: ColorsManager.lightGray,
                                          //           child: GestureDetector(
                                          //             onTap: cartItem.remove,
                                          //             child: SizedBox(
                                          //               height: 35.h,
                                          //               width: 35.w,
                                          //               child: const Icon(CupertinoIcons.arrow_down_circle,size: 18,),),
                                          //
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       Container(
                                          //           padding: const EdgeInsets.symmetric(
                                          //               horizontal: 10),
                                          //           child:  Text(
                                          //             "${cartItem.quantity}",
                                          //             style: const TextStyle(
                                          //                 fontSize: 16,
                                          //                 color:ColorsManager.mainMauve,
                                          //                 fontWeight: FontWeight.bold),
                                          //           )),
                                          //       // mins
                                          //       ClipOval(
                                          //         child: Material(
                                          //           color: ColorsManager.lightGray,
                                          //
                                          //           child: GestureDetector(
                                          //             onTap: cartItem.add,
                                          //             child: const SizedBox(
                                          //               height: 35,
                                          //               width: 35,
                                          //               child: Icon(CupertinoIcons.arrow_up_circle,size: 18,),
                                          //             ),
                                          //
                                          //           ),
                                          //         ),
                                          //       )
                                          //
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (dismissed) {
                                cartItem.deleteProduct(products[index]);
                              },
                            );
                          },
                          itemCount: products.length,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: 130.h,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total : ",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.mainMauve),
                            ),
                            Text(
                              "\$${cartItem.price}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.mainMauve),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 3.5,
                                  width: double.infinity,
                                  child: Wrap(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 30.h, right: 30, left: 30),
                                        child: Text(
                                          'Select Payment',
                                          style: TextStyles.font18BlackMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 15.h),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => PaymentManagerTest
                                                  .makePayment(
                                                      cartItem.price, 'USD'),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                width: 60.w,
                                                height: 75.h,
                                                child: const Image(
                                                  image: AssetImage(
                                                      'assets/icons/download.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          PaypalCheckout(
                                                        sandboxMode: true,
                                                        clientId:
                                                            "AQVD93hnyMgKMXYdkQIJw1nzgkjyHB7WMPv_bGPUEOvUfUrTVgBtbITkVcu3PqrvqbItcBGiv1m2Ioih",
                                                        secretKey:
                                                            "EElhvSLkTHjvimbetZiTayN0E1VhL9ex1fZtKywIiEDwCxfII8bH-Psi4iQSdTuTgLcoih9DpAbvDuYo",
                                                        returnURL:
                                                            "success.snippetcoder.com",
                                                        cancelURL:
                                                            "cancel.snippetcoder.com",
                                                        transactions: const [
                                                          {
                                                            "amount": {
                                                              "total": '70',
                                                              "currency": "USD",
                                                              "details": {
                                                                "subtotal":
                                                                    '70',
                                                                "shipping": '0',
                                                                "shipping_discount":
                                                                    0
                                                              }
                                                            },
                                                            "description":
                                                                "The payment transaction description.",
                                                            // "payment_options": {
                                                            //   "allowed_payment_method":
                                                            //       "INSTANT_FUNDING_SOURCE"
                                                            // },
                                                            "item_list": {
                                                              "items": [
                                                                {
                                                                  "name":
                                                                      "Apple",
                                                                  "quantity": 4,
                                                                  "price": '5',
                                                                  "currency":
                                                                      "USD"
                                                                },
                                                                {
                                                                  "name":
                                                                      "Pineapple",
                                                                  "quantity": 5,
                                                                  "price": '10',
                                                                  "currency":
                                                                      "USD"
                                                                }
                                                              ],

                                                              // shipping address is not required though
                                                              //   "shipping_address": {
                                                              //     "recipient_name": "Raman Singh",
                                                              //     "line1": "Delhi",
                                                              //     "line2": "",
                                                              //     "city": "Delhi",
                                                              //     "country_code": "IN",
                                                              //     "postal_code": "11001",
                                                              //     "phone": "+00000000",
                                                              //     "state": "Texas"
                                                              //  },
                                                            }
                                                          }
                                                        ],
                                                        note:
                                                            "Contact us for any questions on your order.",
                                                        onSuccess:
                                                            (Map params) async {
                                                          print(
                                                              "onSuccess: $params");
                                                        },
                                                        onError: (error) {
                                                          print(
                                                              "onError: $error");
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        onCancel: () {
                                                          print('cancelled:');
                                                        },
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                width: 60.w,
                                                height: 75.h,
                                                child: const Image(
                                                  image: AssetImage(
                                                      'assets/icons/download (1).png'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorsManager.mainMauve,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Check Out",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

//Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: GestureDetector(
//                 onTapUp: (details) {
//                   // showCustomMenu(details,context,products[index]);
//                   // BuyCubit.get(context).showCustomMenu(details, context, products[index]);
//                 },
//                 child: Container(
//                   height: MediaQuery
//                       .of(context)
//                       .size
//                       .height * .15,
//                   color: Colors.blue[100],
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: MediaQuery
//                             .of(context)
//                             .size
//                             .height * .15 / 2,
//                         backgroundImage: AssetImage(
//                             products[index].imgPath),
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment
//                               .spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 35),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment
//                                     .center,
//                                 children: [
//                                   Text(products[index].name,
//                                     style: TextStyle(fontSize: 20,
//                                         fontWeight: FontWeight
//                                             .bold),),
//                                   SizedBox(height: 15,),
//                                   Text('\$ ${products[index].price}',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight
//                                           .bold,
//                                       fontSize: 15,
//                                     ),),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 25),
//                               child: Text(products[index].pQuantity
//                                   .toString(),style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold
//                               ),),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             )
