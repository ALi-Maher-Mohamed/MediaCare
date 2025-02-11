import 'package:flutter/material.dart';
import '../../login/login_view.dart';
import '../../login/widgets/dont_have_email_password.dart';
import 'register_form.dart';
import 'register_header.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                RegisterForm(),
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
