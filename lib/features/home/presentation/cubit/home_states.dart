import 'package:store_app/features/home/data/models/product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<ProductModel> products;

  HomeSuccess(this.products);
}

class HomeError extends HomeStates {
  final String message;

  HomeError(this.message);
}
