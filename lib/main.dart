import 'package:flutter/material.dart';
import 'package:media_care/zoom_drawer.dart';

void main() async {
  // await dotenv.load();

  runApp(const MediCare());
}

class MediCare extends StatelessWidget {
  const MediCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'),
      builder: (context, child) {
        return Directionality(
          textDirection:
              TextDirection.ltr, // يجعل التطبيق بالكامل من اليمين لليسار
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
