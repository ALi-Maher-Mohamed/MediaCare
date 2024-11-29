import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utlis/app_color.dart';
import 'dont_have_email_password.dart';
import 'email_and_passowrd_form.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 300,
                    width: 300,
                    child: Lottie.asset(
                      'assets/animation/doctorWelcomed.json',
                    )),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Column(
                    children: [
                      Text(
                        '...مرحبا بعودتك',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'سجل دخولك ',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                EmailAndPasswordForm(),
                SizedBox(
                  height: 30,
                ),
                DontHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
