import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Auth/register/data/models/register_model.dart';
import 'package:media_care/presentation/views/Auth/register/data/repo/register_repo.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterRepo registerRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bithDateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfimController =
  TextEditingController();

  bool isVisible = true;
  bool isVisibleConfirm = true;
  GlobalKey<FormState> registerKey = GlobalKey();
  bool isLoading = false;
  RegisterCubit({required this.registerRepo}) : super(RegisterInitialState());
  Future<void> registerUser() async {
    isLoading = true;
    emit(RegisterLoadingState());
    try {
      Either<Failure, RegisterModel> response = await registerRepo.registerUser(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        birth_date: bithDateController.text,
        password: passwordController.text,
        password_confirmation: passwordConfimController.text,
      );

      response.fold(
            (failure) {
          isLoading = false;
          emit(RegisterErrorState(failure.errMessage));
        },
            (data) {
          isLoading = false;
          emit(RegisterSuccessState());
        },
      );
    } catch (e) {
      isLoading = false;
      emit(RegisterErrorState(e.toString()));
    }
  }

  void changeVisibility() {
    isVisible = !isVisible; // Toggle the value
    emit(RegisterChangeVisibilityState());
  }

  void changeConfirmVisibility() {
    isVisibleConfirm = !isVisibleConfirm;
    emit(RegisterChangeVisibilityState());
  }

  void RegisterUserValidate() {
    if (registerKey.currentState!.validate()) {
      registerUser();
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    bithDateController.dispose();
    passwordController.dispose();
    passwordConfimController.dispose();
    return super.close();
  }
}
