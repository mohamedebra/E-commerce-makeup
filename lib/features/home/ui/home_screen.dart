import 'package:e_commerce_makeup/core/theming/styles.dart';
import 'package:e_commerce_makeup/features/auth/login/ui/login_screen.dart';
import 'package:e_commerce_makeup/features/home/ui/widget/categorie.dart';
import 'package:e_commerce_makeup/features/home/ui/widget/categorie_items_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../featured/ui/featured.dart';
import '../data/model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scffoldKey = GlobalKey<ScaffoldState>();
  List categories = ['Child', 'Man', 'Woman'];
  List all = [
    'All',
  ];
  List selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scffoldKey,
      backgroundColor: const Color(0xFFe4f0eb),
      appBar: AppBar(
        backgroundColor: const Color(0xFFe4f0eb),
        leading: GestureDetector(
          onTap: () {
            scffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15.w,
              backgroundImage: const AssetImage('assets/icons/Error.png'),
            ),
          ),
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  'Elizabeth',
                  style: TextStyle(fontSize: 15.sp),
                )
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: CircleAvatar(
              radius: 20.h,
              backgroundColor: ColorsManager.lighterGray,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.notificationScreen);
                  },
                  icon: SvgPicture.asset('assets/svgs/Alert.svg')),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Search Widget
          // categories
          Container(
            height: 20.h,
          ),
          // CategoriesWidget
          // Items
          CarouselSlider(
              items: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-vector/realistic-beauty-sale-banner-with-offer_52683-94987.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/top-view-arrangement-with-beauty-bag-copy-space_23-2148301851.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/makeup-brushes-with-whirling-pink-powder_23-2148208975.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 180,
                aspectRatio: 16 / 10,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              )),

          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const Text(
              "Categories",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: ColorsManager.mainMauve),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
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
                              const StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              const StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              5),
                          label: Text(
                            all[index],
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          selected: false,
                          onSelected: (bool selected) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Category(
                                          selectedCategories:
                                              selectedCategories,
                                          selected: selected,
                                        )));
                            // updateDisplayedProducts();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Wrap(
                    spacing: 8.0.w,
                    children: List<Widget>.generate(
                      categories.length,
                      (int index) {
                        return FilterChip(
                          shape: OutlinedBorder.lerp(
                              const StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              const StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              5),
                          label: Text(
                            categories[index],
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          selected: false,
                          onSelected: (bool selected) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Category(
                                          selectedCategories:
                                              selectedCategories,
                                          selected: selected,
                                        )));

                            // updateDisplayedProducts();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const Text(
              "Best Selling",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: ColorsManager.mainMauve),
            ),
          ),
          // Items Widgets
          ItemsWidgets(
            scffoldKey: scffoldKey,
          ),
        ],
      ),
      drawer: Drawer(
        // Example Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //
                  //   decoration:  BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25)
                  //   ),
                  //   width: 70.w,
                  //   height: 75.h,
                  //   child: Image(image: AssetImage('assets/images/04_Sign_In.png'),),
                  // ),
                  CircleAvatar(
                    backgroundImage:
                        const AssetImage('assets/images/download.jpg'),
                    radius: 30.w,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Drawer Header',
                          style: TextStyles.font18BlackMedium),
                      Text('user@example.com',
                          style: TextStyles.font14DarkBlueMedium
                              .copyWith(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.2)),
                  child: const Icon(
                    CupertinoIcons.bag,
                    color: ColorsManager.mainMauve,
                  )),
              title: const Text('Products'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.2)),
                  child: const Icon(
                    CupertinoIcons.star,
                    color: ColorsManager.mainMauve,
                  )),
              title: const Text('Featured'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeaturedScreen()));
              },
            ),
            ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.2)),
                  child: const Icon(
                    CupertinoIcons.heart,
                    color: ColorsManager.mainMauve,
                  )),
              title: const Text('Wishlist'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.2)),
                  child: const Icon(
                    CupertinoIcons.shopping_cart,
                    color: ColorsManager.mainMauve,
                  )),
              title: const Text('My Card'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.2)),
                  child: const Icon(
                    CupertinoIcons.person,
                    color: ColorsManager.mainMauve,
                  )),
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.2)),
                  child: const Icon(
                    Icons.output,
                    color: ColorsManager.mainMauve,
                  )),
              title: const Text('Logout'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
            // Add more ListTile if needed
          ],
        ),
      ),
    );
  }
}
