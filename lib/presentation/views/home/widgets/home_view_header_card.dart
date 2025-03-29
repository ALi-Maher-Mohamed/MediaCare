import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/robot_view.dart';
import 'package:media_care/presentation/views/Ai_feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/Ai_feature/Labs_analytics/repo/Labs_analytics_repo_impl.dart';
import 'package:media_care/presentation/views/Ai_feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/Ai_feature/prescription_analysis/repo/Prescription_repo_impl.dart';
import 'package:media_care/presentation/views/Ai_feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/Ai_feature/symptom_analysis/repos/symptom_analysis_repo_impl.dart';

class HomeViewHeaderCard extends StatelessWidget {
  const HomeViewHeaderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).primaryColor), // تعديل: تتبع الـ Theme
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context)
            .colorScheme
            .surface, // تعديل: تتبع الـ Theme بدل lightGrey
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text('عندك سؤال؟',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .primaryColor, // تعديل: تتبع الـ Theme
                        )),
                Text('أسال الروبوت عن صحتك',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18.sp,
                          color: Theme.of(context)
                              .primaryColor, // تعديل: تتبع الـ Theme
                          fontWeight: FontWeight.bold,
                        )),
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RobotView();
                      },
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(context)
                          .primaryColor, // تعديل: تتبع الـ Theme
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12),
                      child: Text(
                        'اسأل الان !',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // تعديل: تتبع الـ Theme
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100.h,
                width: 100.w,
              ),
              Positioned(
                top: -30,
                left: 0,
                right: 0,
                child: Container(
                  height: 120.h,
                  child: Image.asset(
                    fit: BoxFit.fitHeight,
                    'assets/images/dr_robot.png',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
