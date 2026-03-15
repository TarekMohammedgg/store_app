import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/login/prefs.dart';
import 'package:store_app/features/profile/data/repo/profile_repo.dart';
import 'package:store_app/features/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  final ProfileRepo _profileRepo;

  Future<void> getCurrentUser() async {
    try {
      emit(ProfileLoading());
      final user = await _profileRepo.getCurrentUser();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(ProfileLogoutLoading());
      await CacheHelper.clear();
      emit(ProfileLogoutSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
