import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/splash/splash_view.dart';

void main() async {
  // await dotenv.load();

  runApp(const MediCare());
}

class MediCare extends StatelessWidget {
  const MediCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
