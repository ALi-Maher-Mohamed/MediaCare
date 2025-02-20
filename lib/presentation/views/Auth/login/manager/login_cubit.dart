import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../data/repo/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepo loginRepo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey();
  bool isVisible = true;
  bool isLoading = false;
  LoginCubit({required this.loginRepo}) : super(LoginInitial());
  Future<void> loginUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;
    emit(LoginLoading());
    var response = await loginRepo.loginUser(
        email: emailController.text, password: passwordController.text);
    response.fold(
      (failure) {
        isLoading = false;
        emit(LoginError(error: failure.errMessage));
      },
      (token) {
        isLoading = false;
        pref.setString("token", token.accessToken ?? "");
        emit(LoginSucess());
      },
    );
  }

  void changeVisibility() {
    isVisible = !isVisible; // Toggle the value
    emit(LoginChangeVisibilityState());
  }

  void LoginUserValidate() {
    if (loginKey.currentState!.validate()) {
      loginUser();
    }
  }
}
