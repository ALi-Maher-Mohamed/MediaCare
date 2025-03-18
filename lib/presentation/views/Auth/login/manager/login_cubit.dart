import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import '../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepo loginRepo;

  LoginCubit({required this.loginRepo}) : super(LoginInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  GlobalKey<FormState> loginKey = GlobalKey();

  Future<void> loginUser() async {
    isLoading = true;
    emit(LoginLoading());
    var response = await loginRepo.loginUser(
        email: emailController.text, password: passwordController.text);
    response.fold(
      (failure) {
        isLoading = false;
        emit(LoginError(error: failure.errMessage));
      },
      (data) async {
        String token = data.accessToken!;
        await SharedPreference().saveToken(token);
        isLoading = false;
        if (data.user?.emailVerifiedAt == null) {
          emit(LoginError(error: 'Please verify your email before logging in'));
          return;
        }
        emit(LoginSucess());
      },
    );
  }

  void changeVisibility() {
    isVisible = !isVisible;
    emit(LoginChangeVisibilityState());
  }

  void LoginUserValidate() {
    if (loginKey.currentState!.validate()) {
      loginUser();
    }
  }

  Future<void> checkLoginStatus() async {
    String? token = await SharedPreference().getToken();
    if (token != null && token.isNotEmpty) {
      emit(LoginSucess());
    } else {
      emit(LoginInitial());
    }
  }

  // Future<void> logout() async {
  //   emit(LogoutInitial());
  //   emit(LogoutLoading());
  //   await SharedPreference().clearToken();
  //   emit(LogoutSucess());
  //   emailController.clear();
  //   passwordController.clear();
  //   emit(LoginInitial());
  // }
}
