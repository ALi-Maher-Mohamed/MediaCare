import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/Ai_feature/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/Ai_feature/widgets/result_screen.dart';

class AnalysisScreen extends StatelessWidget {
  final List<Map<String, String>> cards = [
    {
      'title': 'تحليل المختبرات',
      'type': 'lab',
      'description': 'رفع صورة تحليل المختبر لتحليل النتائج بدقة.',
    },
    {
      'title': 'تحليل الروشتة',
      'type': 'prescription',
      'description': 'رفع صورة الروشتة الطبية للحصول على التفاصيل.',
    },
    {
      'title': 'تحليل الأطفال',
      'type': 'child',
      'description': 'قم بتحميل صورة الطفل لتحليل الحالة.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          final isPrescriptionCard = cards[index]['type'] == 'prescription';
          return Card(
            elevation: 5,
            child: InkWell(
              onTap: isPrescriptionCard
                  ? () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        final formData = FormData.fromMap({
                          'image':
                              await MultipartFile.fromFile(pickedFile.path),
                        });
                        context
                            .read<AnalysisCubit>()
                            .analyzeImage(cards[index]['type']!, formData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ResultScreen(type: cards[index]['type']!),
                          ),
                        );
                      }
                    }
                  : () {
                      // الكروت الأخرى غير نشطة حاليًا
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('هذه الميزة تحت الإنشاء')),
                      );
                    },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image, size: 50, color: Colors.teal),
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
    );
  }
}
