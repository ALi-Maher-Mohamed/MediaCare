import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_state.dart';

class LabAnalysisResultScreen extends StatelessWidget {
  final String type;

  const LabAnalysisResultScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text('نتيجة التحليل ',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold)),
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<LabAnalysisCubit, LabAnalysisState>(
        builder: (context, state) {
          if (state is LabAnalysisLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LabAnalysisFailure) {
            print(state.errorMessage);
            return Center(child: Text(state.errorMessage));
          } else if (state is LabAnalysisSuccess) {
            final result = state.analysisData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'lab') ...[
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(Icons.science, color: AppColors.primary),
                        SizedBox(width: 8.w),
                        Text(
                          'نتائج الاختبارات:',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Card(
                      surfaceTintColor: AppColors.primary2,
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
                                  'التفسير:',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(result.interpretation ?? 'لا توجد تفسير'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Card(
                      surfaceTintColor: AppColors.primary2,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.recommend, color: AppColors.primary),
                                SizedBox(width: 8.w),
                                Text(
                                  'التوصيات:',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            ...?result.recommendations?.map((rec) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0.h),
                                      child: Text(rec),
                                    )) ??
                                [const Text('لا توجد توصيات')],
                          ],
                        ),
                      ),
                    ),
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
                              result.warning ?? 'لا يوجد تحذير',
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ...result.testResults.asMap().entries.map((entry) {
                      final index = entry.key;
                      final test = entry.value;
                      return Card(
                        surfaceTintColor: AppColors.primary2,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اختبار ${index + 1}: ${test.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              SizedBox(height: 5.h),
                              Text('القيمة: ${test.value}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  )),
                              Text('الوحدة: ${test.unit}'),
                              Text('الحالة: ${test.status}',
                                  style: TextStyle(
                                    color: (test.status?.toLowerCase() ==
                                            'غير طبيعي')
                                        ? Colors.redAccent
                                        : Colors.green,
                                  )),
                              Text(
                                'ملاحظات: ${test.notes}',
                                style: TextStyle(
                                  color: (test.status?.toLowerCase() ==
                                          'غير طبيعي')
                                      ? Colors.redAccent
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 20.h),
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
