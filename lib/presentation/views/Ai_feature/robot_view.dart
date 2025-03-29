import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/AI_Feature/widgets_robot_view/robot_app_bar.dart';
import 'package:media_care/presentation/views/AI_Feature/widgets_robot_view/robot_card_list.dart';

class RobotView extends StatelessWidget {
  const RobotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // توافق مع الثيم
      appBar: RobotAppBar(),
      body: RobotCardList(),
    );
  }
}
