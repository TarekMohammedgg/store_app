import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/login/cubit/login_states.dart';
import 'package:store_app/features/login/models/user_model.dart';
import 'package:store_app/features/login/prefs.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginIntialState()) {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com/",
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
  late final Dio dio;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      final response = await dio.post(
        "auth/login",
        data: {"username": username, "password": password},
      );
      if (response.statusCode == 200) {
        UserModel data = UserModel.fromJson(response.data);
        if (data.accessToken != null) {
          CacheHelper.saveData("AccessToken", data.accessToken);
          log("accesstoken saved in shared prefs ");
        }
        if (data.refreshToken != null) {
          CacheHelper.saveData("RefreshToken", data.refreshToken);
          log("refreshtoken saved in shared prefs ");
        }
        emit(LoginSuccessState(user: data));

      } else {
        emit(LoginFailedState(errmsg: "Error Status code not 200 "));
      }
    } catch (e) {
      emit(LoginFailedState(errmsg: e.toString()));
      log(e.toString());
    }
  }
}
