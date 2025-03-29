import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SymptomDiagnosisCard extends StatelessWidget {
  final String? diagnosis;

  const SymptomDiagnosisCard({super.key, this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface, // خلفية من الثيم
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.diagnoses,
                    color:
                        Theme.of(context).colorScheme.primary), // لون من الثيم
                SizedBox(width: 8.w),
                Text(
                  'التشخيص المحتمل:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                      ), // نمط من الثيم
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              diagnosis ?? 'غير محدد',
              style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
            ),
          ],
        ),
      ),
    );
  }
}
