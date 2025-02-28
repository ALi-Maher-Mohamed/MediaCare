import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepo loginRepo;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginCubit({required this.loginRepo}) : super(LoginInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey();
  bool isVisible = true;
  bool isLoading = false;

  Future<void> loginUser() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
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
        isLoading = false;
        // pref.setString("token", token.accessToken ?? "");
        if (data.user!.emailVerifiedAt == null) {
          emit(LoginError(error: 'Please verify your email before logging in'));
          return;
        }
        await secureStorage.write(key: "token", value: data.accessToken);
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

  Future<void> checkLoginStatus() async {
    String? token = await secureStorage.read(key: "token");

    if (token != null && token.isNotEmpty) {
      emit(LoginSucess()); // User is already logged in
    } else {
      emit(LoginInitial()); // Show login screen
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: "token");
    emailController.clear();  // Clear email field
    passwordController.clear();  // Clear password field/ Remove token
    emit(LoginInitial()); // Reset login state
  }
}
