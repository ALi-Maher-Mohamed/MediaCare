import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/home/home_view.dart';
import 'package:media_care/presentation/views/splash/splash_view.dart';
import 'package:media_care/presentation/views/splash/widgets/splash_screen.dart';

import 'presentation/views/search/search_view.dart';

void main() {
  runApp(const MediCare());
}

class MediCare extends StatelessWidget {
  const MediCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
