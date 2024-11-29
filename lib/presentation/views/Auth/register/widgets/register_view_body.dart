import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_care/presentation/views/Auth/login/widgets/custom_text_form_field.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'First',
                validator: (p0) => '',
              ),
              CustomTextField(
                label: 'First',
                validator: (p0) => '',
              )
            ],
          ),
        ),
      ),
    );
  }
}
