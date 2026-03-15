import 'package:dio/dio.dart';
import 'package:store_app/features/signup/data/models/signup_request_model.dart';

class SignupRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/",
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Map<String, dynamic>> signup(SignupRequestModel request) async {
    final response = await _dio.post(
      "users/add",
      data: request.toJson(),
    );
    return response.data;
  }
}
