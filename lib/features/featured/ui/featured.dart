import 'package:e_commerce_makeup/core/sql/sql_add_product.dart';
import 'package:e_commerce_makeup/features/featured/logic/featured_cubit.dart';
import 'package:e_commerce_makeup/features/featured/logic/featured_state.dart';
import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theming/colors.dart';
import '../../itemDetails/view/widgets/item_details_appbar.dart';
import '../../itemDetails/view/widgets/rating.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturedCubit()..fetchData(),
      child: BlocBuilder<FeaturedCubit,FeaturedState>(
        builder: (context,state){
          if(state is FeaturedLoading){
            return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
          if(state is FeaturedLoaded) {
            return Scaffold(
              backgroundColor: ColorsManager.bachGroundScaffold,
           body: Column(
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
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 30,left: 20),
                         child: IconButton(onPressed: (){
                           Navigator.pop(context);
                         }, icon: Icon(Icons.arrow_left)),
                       ),
                       const Center(
                           child: Padding(
                             padding: EdgeInsets.only(top: 30,right: 120),
                             child: Text(
                               'My Featured',
                               style: TextStyle(fontSize: 25),
                             ),
                           )),
                     ],
                   )),

               Expanded(
                 child: ListView.builder(
                   itemBuilder: (context, index) {
                     return Dismissible(
                       key: Key(state.list[index].name),
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
                                     image:
                                     AssetImage(state.list[index].imgPath),
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
                                         state.list[index].name,
                                         style: const TextStyle(fontSize: 20),
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Text(
                                         "\$${state.list[index].price}",
                                         style: const TextStyle(fontSize: 17),
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(
                                             horizontal: 20),
                                         child: Text(
                                           "${state.list[index].averageRating}",
                                           style: const TextStyle(fontSize: 17),
                                         ),
                                       ),

                                     ],
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(top: 35),
                                     child: ProductRatingWidget(productId: state.list[index].id, item: state.list[index],),
                                   ),

                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),
                       onDismissed: (dismissed) {
                         deleteProduct(state.list[index],state.list);
                         // cartItem.deleteProduct(products[index]);
                       },
                     );
                   },
                   itemCount: state.list.length,
                 ),
               ),
             ],
           ),
         );
          }
          return const Scaffold(body: Center(child: Text('data'),),);
        },

      ),
    );
  }
  Future<void> deleteProduct(Item product,productsList) async {
    var sqldb = DatabaseHelperProduct.instance;

    // Assuming `product.id` is the way to access the id of the product
    // Also assuming id is of type int
    int response = await sqldb.delete("my_table", "id = ${product.id}");

    if (response > 0) {
      // Assuming you have access to your list of products here, e.g., `productsList`
      // Remove the product from your list based on matching id
      setState(() {
        productsList.removeWhere((element) => element.id == product.id);
      });
    }
  }
}
