import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Auth/login/manager/login_cubit.dart';
import '../../../../../core/utils/app_color.dart';
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
                ////This for email
                autofillHints: [AutofillHints.email],
                inputType: TextInputType.emailAddress,
                controller: data.emailController,
                // ignore: body_might_complete_normally_nullable
                validator: AppValidators.validateEmail,
                label: 'Email',
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                //This for password
                autofillHints: [AutofillHints.password],
                validator: AppValidators.validatePassword,
                controller: data.passwordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<LoginCubit>().changeVisibility();
                  },
                  icon: Icon(
                    data.isVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primary,
                  ),
                ),
                isObscureText: context.watch<LoginCubit>().isVisible,
                label: 'Password',
              ),
              SizedBox(
                height: 30,
              ),
              CustomSubmitButton(
                  onPresed: () {
                    data.LoginUserValidate();
                  },
                  text: 'Submit')
            ],
          ),
        ));
  }
}
