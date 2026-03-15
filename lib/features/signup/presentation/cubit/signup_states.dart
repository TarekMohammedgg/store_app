abstract class SignupStates {}

class SignupInitial extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupSuccess extends SignupStates {
  final Map<String, dynamic> data;
  SignupSuccess(this.data);
}

class SignupError extends SignupStates {
  final String message;
  SignupError(this.message);
}
