import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/login_cubit.dart';
import '../../../../../core/utils/components/validators.dart';
import 'custom_login_button.dart';
import 'custom_text_form_field.dart';

class EmailAndPasswordForm extends StatelessWidget {
  EmailAndPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var data = context.read<LoginCubit>();
    return Form(
        key: data.loginKey,
        child: AutofillGroup(
          child: Column(
            children: [
              CustomTextField(
                autofillHints: [AutofillHints.email],
                inputType: TextInputType.emailAddress,
                controller: data.emailController,
                validator: AppValidators.validateEmail,
                label: 'الايميل',
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomTextField(
                autofillHints: [AutofillHints.password],
                validator: AppValidators.validatePassword,
                controller: data.passwordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<LoginCubit>().changeVisibility();
                  },
                  icon: Icon(
                    data.isVisible ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                isObscureText: context.watch<LoginCubit>().isVisible,
                label: 'كلمة المرور',
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomSubmitButton(
                  onPresed: () {
                    data.LoginUserValidate();
                  },
                  text: 'تسجيل الدخول'),
            ],
          ),
        ));
  }
}
