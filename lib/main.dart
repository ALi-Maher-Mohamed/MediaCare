import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';

void main() {
  runApp(const MediCare());
}

class MediCare extends StatelessWidget {
  const MediCare({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
