import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Auth/login/widgets/dont_have_email_password.dart';
import 'package:media_care/presentation/views/Auth/register/widgets/register_form.dart';
import 'package:media_care/presentation/views/Auth/register/widgets/register_header.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegisterHeader(),
                SizedBox(
                  height: 20,
                ),
                Align(alignment: Alignment.center, child: RegisterForm()),
                DontHaveAccountText(
                  router: LoginView(),
                  text: "Already have an Account  ",
                  boldText: 'Log In',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
