import 'package:dio/dio.dart';
import 'package:store_app/features/home/data/models/product_model.dart';

class HomeRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/",
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<ProductModel>> getAllProducts() async {
    final response = await _dio.get("products");
    List<dynamic> data = response.data["products"];
    return data.map((product) => ProductModel.fromJson(product)).toList();
  }
}
