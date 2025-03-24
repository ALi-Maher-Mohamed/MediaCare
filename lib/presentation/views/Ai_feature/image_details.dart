import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/result_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/symptom_result_screen.dart';

import 'Labs_analytics/labResult_screen.dart';

class ImageDetailView extends StatelessWidget {
  final String imagePath;
  final String type;

  const ImageDetailView({required this.imagePath, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.primary),
        centerTitle: true,
        title: Text('تفاصيل الصورة ',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold)),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                final fieldName = type == 'lab' ? 'file' : 'image';
                final formData = FormData.fromMap({
                  fieldName: await MultipartFile.fromFile(imagePath),
                });
                if (type == 'prescription') {
                  context
                      .read<PrescriptionCubit>()
                      .analyzeImage(type, formData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PrescriptionResultScreen(type: type),
                    ),
                  );
                } else if (type == 'lab') {
                  context
                      .read<LabAnalysisCubit>()
                      .analyzeLabTest(type, formData);
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
                    const SnackBar(content: Text('هذه الميزة تحت الإنشاء')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 32.0.w),
              ),
              child: Text(
                'تحليل الصورة',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
