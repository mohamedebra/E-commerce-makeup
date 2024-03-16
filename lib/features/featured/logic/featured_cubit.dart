import 'package:bloc/bloc.dart';
import 'package:e_commerce_makeup/core/sql/sql_add_product.dart';
import 'package:e_commerce_makeup/core/sql/sql_rating.dart';
import 'package:e_commerce_makeup/features/featured/logic/featured_state.dart';
import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:meta/meta.dart';

class FeaturedCubit extends Cubit<FeaturedState> {
  FeaturedCubit() : super(FeaturedInitial());

  // List<Item> item = [];
  fetchData() async {
    emit(FeaturedLoading());

    try {
      var db = DatabaseHelperProduct.instance;
      List<Item> item = await db.queryAllRows();
      emit(FeaturedLoaded(item));
    } catch (e) {
      emit(FeaturedError());
    }
  }
}
