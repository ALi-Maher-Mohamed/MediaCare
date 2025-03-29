import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/prescription_result_view.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/symptom_result_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/labResult_screen.dart';

class ImageAnalysisButton extends StatelessWidget {
  final String imagePath;
  final String type;

  const ImageAnalysisButton({
    required this.imagePath,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          final fieldName = type == 'lab' ? 'file' : 'image';
          final formData = FormData.fromMap({
            fieldName: await MultipartFile.fromFile(imagePath),
          });
          if (type == 'prescription') {
            context.read<PrescriptionCubit>().analyzeImage(type, formData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrescriptionResultScreen(type: type),
              ),
            );
          } else if (type == 'lab') {
            context.read<LabAnalysisCubit>().analyzeLabTest(type, formData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LabAnalysisResultScreen(type: type),
              ),
            );
          } else if (type == 'symptom') {
            context
                .read<SymptomAnalysisCubit>()
                .analyzeSymptoms(type, formData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SymptomResultScreen(type: type),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'هذه الميزة تحت الإنشاء',
                  style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.primary, // لون من الثيم
          padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 32.0.w),
        ),
        child: Text(
          'تحليل الصورة',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 18.sp,
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary, // لون النص من الثيم
              ), // نمط من الثيم
        ),
      ),
    );
  }
}
