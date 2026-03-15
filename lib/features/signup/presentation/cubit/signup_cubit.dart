import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/signup/data/models/signup_request_model.dart';
import 'package:store_app/features/signup/data/repo/signup_repo.dart';
import 'package:store_app/features/signup/presentation/cubit/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit(this._signupRepo) : super(SignupInitial());

  final SignupRepo _signupRepo;

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      emit(SignupLoading());
      final request = SignupRequestModel(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
      );
      final data = await _signupRepo.signup(request);
      emit(SignupSuccess(data));
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
