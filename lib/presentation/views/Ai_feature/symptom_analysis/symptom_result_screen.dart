import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_diagnosis_card.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_specialization_card.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_advice_card.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_confidence_score_card.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_message_card.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_medications_header.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_medication_card.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/widgets/symptom_warning_card.dart';

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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<SymptomAnalysisCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoading && state.type == AnalysisType.symptom) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AiFailure && state.type == AnalysisType.symptom) {
            return Center(child: Text(state.errorMessage));
          } else if (state is AiSuccess && state.type == AnalysisType.symptom) {
            final result = state.result;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SymptomDiagnosisCard(diagnosis: result.diagnosis),
                  SizedBox(height: 20.h),
                  SymptomSpecializationCard(
                      recommendedSpecialization:
                          result.recommendedSpecialization),
                  SizedBox(height: 20.h),
                  SymptomAdviceCard(advice: result.advice),
                  SizedBox(height: 20.sp),
                  SymptomConfidenceScoreCard(
                      confidenceScore: result.confidenceScore),
                  SizedBox(height: 20.h),
                  SymptomMessageCard(message: result.message),
                  SizedBox(height: 20.sp),
                  const SymptomMedicationsHeader(),
                  SizedBox(height: 10.h),
                  if (result.suggestedMedications.isNotEmpty)
                    ...result.suggestedMedications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return SymptomMedicationCard(
                          index: index, medication: med);
                    })
                  else
                    const Text('لا توجد أدوية مقترحة'),
                  SizedBox(height: 20.h),
                  SymptomWarningCard(warning: result.medicationWarning),
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
