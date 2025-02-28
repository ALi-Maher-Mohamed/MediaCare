import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'manager/login_cubit.dart';
import '../../../../zoom_drawer.dart';

import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSucess) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(
            "Login Success",
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeView()), // Change to your home screen widget
          );
        } else if (state is LoginLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is LoginError) {
          EasyLoading.showError(state.error);
        }
      },
      builder: (context, state) {
        return LoginViewBody();
      },
    );
  }
}
