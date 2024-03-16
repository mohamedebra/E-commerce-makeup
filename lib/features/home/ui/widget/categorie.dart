import 'package:e_commerce_makeup/core/theming/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatefulWidget {
   Category({super.key,required this.selectedCategories, required this.selected});
  List? selectedCategories ;
  final bool selected ;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List categories =[
    'Child',
    'Man',
    'Woman'
  ];
  List all =[
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bachGroundScaffold,

      body: Column(
        children: [

          Container(
              height: 80,
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

                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },icon: const Icon(Icons.arrow_left),),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 90.w),
                    child: const Text(
                      'My Cart',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Wrap(
                  spacing: 8.0.w,
                  children: List<Widget>.generate(
                    all.length,
                        (int index) {
                      return FilterChip(
                        shape: OutlinedBorder.lerp(
                            const StadiumBorder(side: BorderSide(color: Colors.white,style: BorderStyle.solid)),
                            const StadiumBorder(side: BorderSide(color: Colors.white,style: BorderStyle.solid)),
                            5

                        ),
                        label: Text(all[index],style: TextStyle(fontSize: 13.sp),),
                        selected: widget.selected ? widget.selectedCategories!.contains(all[index]) : true,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              widget.selectedCategories!.add(all[index]);
                            } else {
                              widget.selectedCategories!.remove(all[index]);
                            }
                          });
                          // updateDisplayedProducts();
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 8.w,),
                Wrap(
                  spacing: 8.0.w,
                  children: List<Widget>.generate(
                    categories.length,
                        (int index) {
                      return Row(
                        children: [
                          FilterChip(
                            shape: OutlinedBorder.lerp(
                                const StadiumBorder(side: BorderSide(color: Colors.white,style: BorderStyle.solid)),
                                const StadiumBorder(side: BorderSide(color: Colors.white,style: BorderStyle.solid)),
                                5

                            ),
                            label: Text(categories[index],style: TextStyle(fontSize: 13.sp),),
                            selected: widget.selectedCategories!.contains(categories[index]),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  widget.selectedCategories!.add(categories[index]);
                                } else {
                                  widget.selectedCategories!.remove(categories[index]);
                                }
                              });
                              // updateDisplayedProducts();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
