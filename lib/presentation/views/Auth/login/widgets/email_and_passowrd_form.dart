import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/core/utlis/components/validators.dart';
import 'package:media_care/presentation/views/Auth/login/manager/login_cubit.dart';
import '../../../../../core/utlis/app_regex.dart';
import 'custom_login_button.dart';
import 'custom_text_form_field.dart';
import '../../../../../zoom_drawer.dart';

class EmailAndPasswordForm extends StatelessWidget {
  EmailAndPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var data = context.read<LoginCubit>();
    return Form(
        key: data.loginKey,
        child: Column(
          children: [
            CustomTextField(
              ////This for email
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
              onChanged: (value) {},
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
            CustomLoginButton(
                onPresed: () {
                  data.LoginUserValidate();
                },
                text: 'Submit')
          ],
        ));
  }
}
