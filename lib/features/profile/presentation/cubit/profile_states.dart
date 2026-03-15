import 'package:store_app/features/login/models/user_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileSuccess extends ProfileStates {
  final UserModel user;
  ProfileSuccess(this.user);
}

class ProfileError extends ProfileStates {
  final String message;
  ProfileError(this.message);
}

class ProfileLogoutLoading extends ProfileStates {}

class ProfileLogoutSuccess extends ProfileStates {}
