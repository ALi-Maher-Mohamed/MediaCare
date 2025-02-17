import 'package:flutter/material.dart';
import '../../../../../core/utlis/app_regex.dart';
import 'custom_login_button.dart';
import 'custom_text_form_field.dart';
import '../../../../../zoom_drawer.dart';

class EmailAndPasswordForm extends StatefulWidget {
  const EmailAndPasswordForm({
    super.key,
  });
  @override
  State<EmailAndPasswordForm> createState() => _EmailAndPasswordFormState();
}

class _EmailAndPasswordFormState extends State<EmailAndPasswordForm> {
  bool isSecure = true;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              inputType: TextInputType.emailAddress,
              // ignore: body_might_complete_normally_nullable
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field is required';
                } else if (!AppRegex.isEmailValid(value)) {
                  return 'Enter correct form of email';
                }
              },
              label: 'Email',
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
              onChanged: (value) {},
              isObscureText: isSecure,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field is required';
                } else if (!AppRegex.isPasswordValid(value)) {
                  return 'Enter correct form of password';
                }
                return null;
              },
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
            ),
            SizedBox(
              height: 30,
            ),
            CustomLoginButton(
                onPresed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return HomeView();
                      },
                    ));
                  }
                },
                text: 'Submit')
          ],
        ));
  }
}
