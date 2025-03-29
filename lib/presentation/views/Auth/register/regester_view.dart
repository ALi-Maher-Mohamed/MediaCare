import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Auth/register/data/repo/register_repo_iplm.dart';
import 'manager/register_cubit.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
          registerRepo: RegisterRepoImpl(ApiServiceFunctions(Dio()))),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Register Success");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          } else if (state is RegisterLoadingState) {
            EasyLoading.show(status: 'Loading...');
          } else if (state is RegisterErrorState) {
            if (state.error.contains("email has already been taken")) {
              EasyLoading.showError(
                  "This email is already registered. Try another.");
            } else {
              EasyLoading.showError(state.error);
            }
          }
        },
        builder: (context, state) {
          return RegisterViewBody();
        },
      ),
    );
  }
}
