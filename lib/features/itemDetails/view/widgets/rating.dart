import 'package:e_commerce_makeup/core/sql/sql_add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/sql/sql_rating.dart';
import '../../../../core/theming/colors.dart';
import '../../../home/data/model/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRatingWidget extends StatefulWidget {
  final int productId;
  final Item item;

  const ProductRatingWidget({Key? key, required this.productId, required this.item}) : super(key: key);

  @override
  State<ProductRatingWidget> createState() => _ProductRatingWidgetState();
}

class _ProductRatingWidgetState extends State<ProductRatingWidget> {
  double _averageRating = 0.0;
  var db = DatabaseHelperProduct.instance;

  @override
  void initState() {
    super.initState();
    _loadAverageRating();
  }

  Future<void> _loadAverageRating() async {
    double averageRating = await DatabaseHelper.instance.fetchAverageRating(widget.productId.toString());
    setState(() {
      _averageRating = averageRating;
    });

    // await DatabaseHelper.instance.addProduct(Item(
    //     name: widget.item.name,
    //     imgPath: widget.item.name,
    //     price: widget.item.price,
    //     id: widget.item.id,
    //     averageRating: widget.item.averageRating
    // ));

  }

  Future<void> _submitRating(double rating) async {
    String userId = "${widget.item.id}"; // Assuming each item has a unique ID
    await DatabaseHelper.instance.addOrUpdateRating(widget.productId.toString(), userId, rating);
    // await DatabaseHelper.instance.addProduct(Item(
    //     name: widget.item.name,
    //     imgPath: widget.item.name,
    //     price: widget.item.price,
    //     id: widget.item.id,
    //     averageRating: widget.item.averageRating
    // ));
    db.insert(
        Item(
            name: widget.item.name,
            imgPath: widget.item.imgPath,
            price: widget.item.price,
            id: widget.item.id,
            averageRating: rating
        ));

    await _loadAverageRating(); // Refresh the average rating displayed
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: _averageRating,
      minRating: 1,
      direction: Axis.horizontal,
      itemSize: 20,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: ColorsManager.mainMauve,
      ),
      onRatingUpdate: (rating) {
        _submitRating(rating);
      },
    );
  }
}