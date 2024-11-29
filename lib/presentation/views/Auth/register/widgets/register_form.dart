import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_regex.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Auth/login/widgets/custom_login_button.dart';

import '../../login/widgets/custom_text_form_field.dart';
import 'first_last_names_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirstAndLastNameForm(),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Email',
            validator: (Value) {
              if (!AppRegex.isEmailValid(Value!)) {
                return 'Enter a Valid Email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.phone,
            label: 'Phone',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'field is required';
              } else if (!AppRegex.isPhoneNumberValid(value)) {
                return 'Enter correct form of password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
                child: isSecure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility)),
            label: 'Password',
            isObscureText: isSecure,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'field is required';
              } else if (!AppRegex.isPasswordValid(value)) {
                return 'Enter correct form of password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            isObscureText: isSecure,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
                child: isSecure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility)),
            label: 'Confirm password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'field is required';
              } else if (!AppRegex.isPasswordValid(value)) {
                return 'Enter correct form of password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.datetime,
            label: 'Birth date',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'field is required';
              } else if (!AppRegex.isDateOfBirthValid(value)) {
                return 'Enter Invalid Date';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomLoginButton(
              text: 'Submit',
              onPresed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ));
                }
              })
        ],
      ),
    );
  }
}
