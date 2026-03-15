import 'package:dio/dio.dart';
import 'package:store_app/features/login/models/user_model.dart';
import 'package:store_app/features/login/prefs.dart';

class ProfileRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/",
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<UserModel> getCurrentUser() async {
    final token = CacheHelper.getData("AccessToken");
    final response = await _dio.get(
      "auth/me",
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return UserModel.fromJson(response.data);
  }
}
