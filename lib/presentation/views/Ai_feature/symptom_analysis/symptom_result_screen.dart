import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const SymptomResultScreen({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // توافق مع الثيم
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        centerTitle: true,
        title: Text(
          'نتيجة تحليل الأعراض',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24.sp,
              ), // نمط النص من الثيم
        ),
      ),
      body: BlocBuilder<SymptomAnalysisCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoading && state.type == AnalysisType.symptom) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary, // لون من الثيم
              ),
            );
          } else if (state is AiFailure && state.type == AnalysisType.symptom) {
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            );
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
                    Text(
                      'لا توجد أدوية مقترحة',
                      style:
                          Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                    ),
                  SizedBox(height: 20.h),
                  SymptomWarningCard(warning: result.medicationWarning),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'جاري تحميل النتيجة...',
              style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
            ),
          );
        },
      ),
    );
  }
}
