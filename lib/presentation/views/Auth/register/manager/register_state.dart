part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterChangeVisibilityState extends RegisterState {}

class RegisterFieldChangedState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterDatePickedState extends RegisterState {
  final String birthDate;
  RegisterDatePickedState(this.birthDate);
}

class GoogleSignInLoadingState extends RegisterState {}

class GoogleSignInSuccessState extends RegisterState {}

class GoogleSignInErrorState extends RegisterState {
  final String error;
  GoogleSignInErrorState(this.error);
}

class NavigateToLoginState extends RegisterState {}
