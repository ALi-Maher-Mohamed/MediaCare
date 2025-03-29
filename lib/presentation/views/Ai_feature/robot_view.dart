import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/widgets_robot_view/robot_app_bar.dart';
import 'package:media_care/presentation/views/AI_Feature/widgets_robot_view/robot_card_list.dart';

class RobotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: RobotAppBar(),
      body: RobotCardList(),
    );
  }
}
