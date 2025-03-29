import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/widgets/prescription_details_card.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/widgets/prescription_medications_header.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/widgets/prescription_medication_card.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/widgets/prescription_general_advice_card.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/widgets/prescription_message_card.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/widgets/prescription_warning_card.dart';

class PrescriptionResultScreen extends StatelessWidget {
  final String type;

  const PrescriptionResultScreen({required this.type, super.key});

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
          'نتيجة تحليل الروشتة',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24.sp,
              ), // نمط النص من الثيم
        ),
      ),
      body: BlocBuilder<PrescriptionCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoading && state.type == AnalysisType.prescription) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary, // لون من الثيم
              ),
            );
          } else if (state is AiFailure &&
              state.type == AnalysisType.prescription) {
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            );
          } else if (state is AiSuccess &&
              state.type == AnalysisType.prescription) {
            final result = state.result;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrescriptionDetailsCard(
                      prescriptionDetails: result.prescriptionDetails),
                  SizedBox(height: 20.h),
                  const PrescriptionMedicationsHeader(),
                  SizedBox(height: 10.h),
                  if (result.medications.isNotEmpty)
                    ...result.medications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return PrescriptionMedicationCard(
                          index: index, medication: med);
                    })
                  else
                    Text(
                      'لا توجد أدوية محددة',
                      style:
                          Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                    ),
                  SizedBox(height: 20.h),
                  PrescriptionGeneralAdviceCard(
                      generalAdvice: result.generalAdvice),
                  SizedBox(height: 20.h),
                  PrescriptionMessageCard(message: result.message),
                  SizedBox(height: 20.h),
                  PrescriptionWarningCard(warning: result.warning),
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
