import 'package:store_app/features/login/models/user_model.dart';

abstract class LoginStates {}

class LoginIntialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel user;

  LoginSuccessState({required this.user});
}

class LoginFailedState extends LoginStates {
  final String errmsg;
  LoginFailedState({required this.errmsg});
}

class LoginLoadingState extends LoginStates {}
