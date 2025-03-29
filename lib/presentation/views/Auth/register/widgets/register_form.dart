import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/components/validators.dart';
import '../manager/register_cubit.dart';
import '../../login/widgets/custom_login_button.dart';
import '../../login/widgets/custom_text_form_field.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var data = context.read<RegisterCubit>();
    return Form(
      key: data.registerKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            inputType: TextInputType.name,
            label: 'Full Name',
            controller: data.nameController,
            validator: AppValidators.validateFullName,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.emailAddress,
            label: 'Email',
            controller: data.emailController,
            validator: AppValidators.validateEmail,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.phone,
            label: 'Phone',
            controller: data.phoneController,
            validator: AppValidators.validatePhoneNumber,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.streetAddress,
            label: 'Address',
            controller: data.addressController,
            validator: AppValidators.validateFullName,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.datetime,
            label: 'Birth date',
            controller: data.bithDateController,
            validator: AppValidators.validateFullName,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            validator: AppValidators.validatePassword,
            controller: data.passwordController,
            suffixIcon: IconButton(
              onPressed: () {
                context.read<RegisterCubit>().changeVisibility();
              },
              icon: Icon(
                data.isVisible ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            isObscureText: context.watch<RegisterCubit>().isVisible,
            label: 'Password',
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            validator: (value) => AppValidators.validateConfirmPassword(
                value, data.passwordController.text),
            controller: data.passwordConfimController,
            suffixIcon: IconButton(
              onPressed: () {
                context.read<RegisterCubit>().changeConfirmVisibility();
              },
              icon: Icon(
                data.isVisibleConfirm ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            isObscureText: context.watch<RegisterCubit>().isVisibleConfirm,
            label: 'Confirm Password',
          ),
          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
              text: 'Submit',
              onPresed: () {
                data.RegisterUserValidate();
              }),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
