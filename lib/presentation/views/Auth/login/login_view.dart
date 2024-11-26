// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/presentation/views/Auth/login/widgets/custom_login_button.dart';
import 'package:media_care/presentation/views/Auth/login/widgets/custom_text_field.dart';
import 'package:media_care/presentation/views/Auth/login/widgets/dont_have_email_password.dart';
import 'package:media_care/presentation/views/intro/widgets/custom_text_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    '...مرحبا بعودتك',
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    'سجل دخولك ',
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  label: 'Email',
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  icon: Icon(Icons.visibility),
                  label: 'Password',
                ),
                SizedBox(
                  height: 30,
                ),
                DontHaveAccountText(),
                SizedBox(
                  height: 30,
                ),
                CustomLoginButton(onPresed: () {}, text: 'text')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
