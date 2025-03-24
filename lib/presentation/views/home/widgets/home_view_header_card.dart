import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/robot_view.dart';

import '../../../../core/utils/app_color.dart';

class HomeViewHeaderCard extends StatelessWidget {
  const HomeViewHeaderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(18),
        color: AppColors.lightGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text('عندك سؤال؟',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    )),
                Text('أسال الروبوت عن صحتك',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.primary,
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
                      color: AppColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12),
                      child: Text(
                        ' اسأل الان !',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
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
                  // width: 170.w,
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
