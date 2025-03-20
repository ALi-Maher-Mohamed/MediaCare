import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/image_details.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_view.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo_impl.dart';

class RobotView extends StatelessWidget {
  final List<Map<String, dynamic>> cards = [
    {
      'title': 'تحليل المختبرات',
      'type': 'lab',
      'description': 'رفع صورة تحليل المختبر لتحليل النتائج بدقة.',
      'image': 'assets/images/laboratoryrobot.png',
    },
    {
      'title': 'تحليل الروشتة',
      'type': 'prescription',
      'description': 'رفع صورة الروشتة الطبية للحصول على التفاصيل.',
      'image': 'assets/images/pharmacyrobot.png',
    },
    {
      'title': 'تحليل الأعراض',
      'type': 'symptom',
      'description': 'رفع صورة الأعراض لتحليل الحالة.',
      'image': 'assets/images/ai.png',
    },
    {
      'title': 'أبحث يدويا',
      'type': 'manual',
      'description': 'اكتب الأعراض أو اسم الدواء يدويًا.',
      'image': 'assets/images/manual_input.png', // ضيف صورة مناسبة في assets
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
        BlocProvider(
          create: (context) =>
              SymptomAnalysisCubit(SymptomAnalysisRepositoryImpl(Dio())),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          iconTheme: const IconThemeData(color: AppColors.primary),
          centerTitle: true,
          title: Text('تحليل البيانات',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold)),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final cardType = cards[index]['type']!;
            final cardImage = cards[index]['image']!;
            return Card(
              elevation: 5,
              child: InkWell(
                onTap: () async {
                  if (cardType == 'manual') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManualInputView(),
                      ),
                    );
                  } else {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailView(
                            imagePath: pickedFile.path,
                            type: cardType,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        cardImage,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image,
                              size: 50.sp, color: AppColors.primary);
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      cards[index]['title']!,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cards[index]['description']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
              surfaceTintColor: AppColors.primary2,
            );
          },
        ),
      ),
    );
  }
}
