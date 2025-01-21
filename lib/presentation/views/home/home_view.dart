import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/home/widgets/home_view_body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: HomeViewBody(),
      ),
    );
  }
}
