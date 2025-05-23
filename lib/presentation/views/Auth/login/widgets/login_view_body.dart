import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../register/regester_view.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 300.h,
                    width: 300.w,
                    child: Lottie.asset(
                      'assets/animation/doctorWelcomed.json',
                    )),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Column(
                    children: [
                      Text(
                        'مرحبا بعودتك',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      Text(
                        'سجل دخولك ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                EmailAndPasswordForm(),
                SizedBox(
                  height: 30.h,
                ),
                DontHaveAccountText(
                  router: RegisterView(),
                  text: "ليس لديك حساب؟",
                  boldText: " انشاء حساب جديد",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
