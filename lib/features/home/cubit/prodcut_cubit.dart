import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/cubit/product_states.dart';
import 'package:store_app/features/home/model/product_model.dart';

class ProdcutCubit extends Cubit<ProductStates> {
  ProdcutCubit() : super(ProductInitialState()) {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com/",
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  late final Dio dio;

  Future<void> getAllProducts() async {
    try {
      emit(ProductLoadingState());

      final response = await dio.get("products");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["products"];
        List<ProductModel> products = data
            .map((product) => ProductModel.fromJson(product))
            .toList();
        emit(ProductSuccessState(products: products));
      }
    } catch (e) {
      emit(ProductFailedState(errmsg: e.toString()));
    }
  }
}
