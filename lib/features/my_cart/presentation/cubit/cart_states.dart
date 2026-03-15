import 'package:store_app/features/home/data/models/product_model.dart';

abstract class CartStates {}

class CartInitial extends CartStates {}

class CartUpdated extends CartStates {
  final List<ProductModel> items;
  final double totalPrice;

  CartUpdated({required this.items, required this.totalPrice});
}
