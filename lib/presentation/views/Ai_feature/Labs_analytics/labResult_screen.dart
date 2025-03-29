import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_result_header.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_interpretation_card.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_recommendations_card.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_warning_card.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_test_result_card.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';

class LabAnalysisResultScreen extends StatelessWidget {
  final String type;
  const LabAnalysisResultScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        centerTitle: true,
        title: Text(
          'نتيجة التحليل',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24.sp,
              ), // نمط من الثيم
        ),
      ),
      body: BlocBuilder<LabAnalysisCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoading && state.type == AnalysisType.lab) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary, // لون من الثيم
              ),
            );
          } else if (state is AiFailure && state.type == AnalysisType.lab) {
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            );
          } else if (state is AiSuccess && state.type == AnalysisType.lab) {
            final result = state.result;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabResultHeader(),
                  SizedBox(height: 20.h),
                  LabInterpretationCard(
                      interpretation: result.interpretation ?? ''),
                  SizedBox(height: 20.h),
                  LabRecommendationsCard(
                      recommendations: result.recommendations),
                  SizedBox(height: 20.h),
                  LabWarningCard(warning: result.warning),
                  SizedBox(height: 20.h),
                  if (result.testResults.isNotEmpty)
                    ...result.testResults.asMap().entries.map((entry) {
                      final index = entry.key;
                      final test = entry.value;
                      return LabTestResultCard(index: index, test: test);
                    })
                  else
                    Text(
                      'لا توجد نتائج اختبارات',
                      style:
                          Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                    ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'يرجى رفع صورة لتحليلها',
              style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
            ),
          );
        },
      ),
    );
  }
}
