import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_state.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart'; // ضيف ده لو مش موجود

class PrescriptionResultScreen extends StatelessWidget {
  final String type;

  const PrescriptionResultScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'نتيجة تحليل $type',
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PrescriptionCubit, PrescriptionState>(
        builder: (context, state) {
          if (state is PrescriptionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrescriptionFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is PrescriptionSuccess) {
            final result = state.prescriptionData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'prescription') ...[
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info, color: AppColors.primary),
                                SizedBox(width: 8.w),
                                Text(
                                  'تفاصيل الروشتة:',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                                'اسم الطبيب: ${result.prescriptionDetails.doctorName}'),
                            Text(
                                'اسم المريض: ${result.prescriptionDetails.patientName}'),
                            Text(
                                'عمر المريض: ${result.prescriptionDetails.patientAge}'),
                            Text(
                                'تاريخ الروشتة: ${result.prescriptionDetails.prescriptionDate}'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(Icons.medical_services, color: AppColors.primary),
                        SizedBox(width: 8.w),
                        Text(
                          'الأدوية:',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ...result.medications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineDetailScreen(
                              medicineName: med.name ?? 'Unknown',
                            ),
                          ),
                        ),
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          child: Padding(
                            padding: EdgeInsets.all(12.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'الدواء ${index + 1}: ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MedicineDetailScreen(
                                              medicineName:
                                                  med.name ?? 'Unknown',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        med.name ?? 'Unknown',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text('الجرعة: ${med.dosage}'),
                                Text('التكرار: ${med.frequency}'),
                                Text('المدة: ${med.duration}'),
                                Text('الغرض: ${med.purpose}'),
                                Text(
                                  'تحذيرات: ${med.warnings}',
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 20.h),
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
                                SizedBox(width: 8.h),
                                Text(
                                  'النصائح العامة:',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            ...result.generalAdvice.entries
                                .map((entry) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0.h),
                                      child: Text(
                                        '${entry.key}: ${entry.value}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sp),
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
                            Text(
                              result.message ?? 'لا يوجد رسالة',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                              result.warning ?? "",
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (type == 'lab') ...[
                    Text('نتائج المختبرات:',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    const Text('هذه ميزة تحت الإنشاء - سيعرض التحليل قريبًا!'),
                  ] else if (type == 'child') ...[
                    Text('تحليل حالة الطفل:',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    const Text('هذه ميزة تحت الإنشاء - سيعرض التحليل قريبًا!'),
                  ],
                ],
              ),
            );
          }
          return const Center(child: Text('يرجى رفع صورة لتحليلها'));
        },
      ),
    );
  }
}
