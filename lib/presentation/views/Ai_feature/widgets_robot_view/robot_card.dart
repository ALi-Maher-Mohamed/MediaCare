import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class RobotCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final VoidCallback onTap;

  const RobotCard({
    required this.title,
    required this.description,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: AppColors.primary2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min, // تحديد الحجم الأدنى لـ Column
          children: [
            SizedBox(
              height: 150.h, // ارتفاع ثابت للصورة (قابل للتعديل حسب التصميم)
              width: double.infinity, // لضمان امتداد الصورة أفقيًا
              child: Image.asset(
                image,
                fit: BoxFit.cover, // ضبط الصورة لتناسب الحاوية
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image,
                    size: 50.sp,
                    color: AppColors.primary,
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
