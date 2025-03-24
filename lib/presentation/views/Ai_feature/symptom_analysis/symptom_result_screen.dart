import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_state.dart';

class SymptomResultScreen extends StatelessWidget {
  final String type;

  const SymptomResultScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'نتيجة تحليل الأعراض',
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
        builder: (context, state) {
          if (state is SymptomAnalysisLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SymptomAnalysisFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is SymptomAnalysisSuccess) {
            final result = state.analysisData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // التشخيص المحتمل
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.diagnoses,
                                  color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Text(
                                'التشخيص المحتمل:',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(result.diagnosis ?? 'غير محدد'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // التخصص الموصى به
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_hospital,
                                  color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Text(
                                'التخصص الموصى به:',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(result.recommendedSpecialization ?? 'غير محدد'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // النصيحة
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lightbulb, color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Text(
                                'النصيحة:',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(result.advice ?? 'لا توجد نصائح'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  // درجة الثقة
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.score, color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Text(
                                'درجة الثقة:',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text('${result.confidenceScore ?? 0}%'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // الرسالة
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.message, color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Text(
                                'رسالة:',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(result.message ?? 'لا توجد رسالة'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  // الأدوية المقترحة
                  Row(
                    children: [
                      Icon(Icons.medical_services, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Text(
                        'الأدوية المقترحة:',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  if (result.suggestedMedications.isNotEmpty)
                    ...result.suggestedMedications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicineDetailScreen(
                                  medicineName: med.name ?? '',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الدواء ${index + 1}: ${med.name ?? 'غير محدد'}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                SizedBox(height: 5.h),
                                Text('الجرعة: ${med.dosage ?? 'غير محدد'}'),
                                Text(
                                    'ملاحظات: ${med.notes ?? 'لا توجد ملاحظات'}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  else
                    const Text('لا توجد أدوية مقترحة'),
                  SizedBox(height: 20.h),
                  // التحذير
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warning, color: Colors.redAccent),
                              SizedBox(width: 8.w),
                              Text(
                                'تحذير:',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            result.medicationWarning ?? 'لا يوجد تحذير',
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('جاري تحميل النتيجة...'));
        },
      ),
    );
  }
}
