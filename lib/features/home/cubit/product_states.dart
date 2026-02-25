import 'package:store_app/features/home/model/product_model.dart';

abstract class ProductStates {}

class ProductLoadingState extends ProductStates {}

class ProductSuccessState extends ProductStates {
  final List<ProductModel> products;

  ProductSuccessState({required this.products});
}

class ProductFailedState extends ProductStates {
  final String errmsg;

  ProductFailedState({required this.errmsg});
}

class ProductInitialState extends ProductStates {}
