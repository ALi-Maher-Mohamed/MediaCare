import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegisterHeader(),
                SizedBox(
                  height: 20.h,
                ),
                RegisterForm(),
                DontHaveAccountText(
                  router: LoginView(),
                  text: "لديك حساب بالفعل؟",
                  boldText: 'تسجيل الدخول',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
