import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/image_details.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/repo/Prescription_repo_impl.dart';

class AnalysisScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cards = [
    {
      'title': 'تحليل المختبرات',
      'type': 'lab',
      'description': 'رفع صورة تحليل المختبر لتحليل النتائج بدقة.',
      'image': 'assets/images/lab_image.jpg', // استبدل بمسار الصورة المناسب
    },
    {
      'title': 'تحليل الروشتة',
      'type': 'prescription',
      'description': 'رفع صورة الروشتة الطبية للحصول على التفاصيل.',
      'image':
          'assets/images/prescription_image.jpg', // استبدل بمسار الصورة المناسب
    },
    {
      'title': 'تحليل الأطفال',
      'type': 'child',
      'description': 'قم بتحميل صورة الطفل لتحليل الحالة.',
      'image': 'assets/images/child_image.jpg', // استبدل بمسار الصورة المناسب
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrescriptionCubit(PrescriptionRepoImpl(Dio())),
        ),
        BlocProvider(
          create: (context) =>
              LabAnalysisCubit(LabAnalysisRepositoryImpl(Dio())),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تحليل البيانات'),
          backgroundColor: Colors.teal,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final cardType = cards[index]['type']!;
            final cardImage = cards[index]['image']!;
            return Card(
              elevation: 5,
              child: InkWell(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailScreen(
                          imagePath: pickedFile.path,
                          type: cardType,
                        ),
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardImage,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image,
                            size: 50, color: Colors.teal);
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cards[index]['title']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cards[index]['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
