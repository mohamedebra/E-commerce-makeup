
import '../../home/data/model/product_model.dart';

class FeaturedState {}

final class FeaturedInitial extends FeaturedState {}
final class FeaturedLoading extends FeaturedState {}
final class FeaturedLoaded extends FeaturedState {
  List<Item> list;

  FeaturedLoaded(this.list);
}
final class FeaturedError extends FeaturedState {}
