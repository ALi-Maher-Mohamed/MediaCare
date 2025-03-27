import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_result_header.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_interpretation_card.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_recommendations_card.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_warning_card.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/widgets/lab_test_result_card.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';

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
        title: Text(
          'نتيجة التحليل',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<LabAnalysisCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoading && state.type == AnalysisType.lab) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AiFailure && state.type == AnalysisType.lab) {
            print(state.errorMessage);
            return Center(child: Text(state.errorMessage));
          } else if (state is AiSuccess && state.type == AnalysisType.lab) {
            final result = state.result;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'lab') ...[
                    SizedBox(height: 20.h),
                    const LabResultHeader(),
                    SizedBox(height: 20.h),
                    LabInterpretationCard(
                        interpretation: result.interpretation ?? ''),
                    SizedBox(height: 20.h),
                    LabRecommendationsCard(
                        recommendations: result.recommendations),
                    SizedBox(height: 20.h),
                    LabWarningCard(warning: result.warning),
                    SizedBox(height: 10.h),
                    ...result.testResults.asMap().entries.map((entry) {
                      final index = entry.key;
                      final test = entry.value;
                      return LabTestResultCard(index: index, test: test);
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
