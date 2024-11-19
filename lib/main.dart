import 'package:flutter/material.dart';

import 'presentation/views/splash/splash_view.dart';

void main() {
  runApp(const MediCare());
}

class MediCare extends StatelessWidget {
  const MediCare({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashView(),
    );
  }
}
