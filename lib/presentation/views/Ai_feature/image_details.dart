import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/labResult_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/widgets/result_screen.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;
  final String type;

  const ImageDetailScreen({required this.imagePath, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الصورة - $type'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder_image.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                // تحديد اسم الحقل بناءً على type
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
                      builder: (context) => LabResultScreen(type: type),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('هذه الميزة تحت الإنشاء')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
              ),
              child: const Text(
                'تحليل الصورة',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
