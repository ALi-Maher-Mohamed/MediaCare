import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/utils/app_color.dart';

class SymptomDiagnosisCard extends StatelessWidget {
  final String? diagnosis;

  const SymptomDiagnosisCard({super.key, this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.diagnoses, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  'التشخيص المحتمل:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(diagnosis ?? 'غير محدد'),
          ],
        ),
      ),
    );
  }
}
