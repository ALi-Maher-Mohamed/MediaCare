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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<PrescriptionCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoading && state.type == AnalysisType.prescription) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AiFailure &&
              state.type == AnalysisType.prescription) {
            return Center(child: Text(state.errorMessage));
          } else if (state is AiSuccess &&
              state.type == AnalysisType.prescription) {
            final result = state.result;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'prescription') ...[
                    PrescriptionDetailsCard(
                        prescriptionDetails: result.prescriptionDetails),
                    SizedBox(height: 20.h),
                    const PrescriptionMedicationsHeader(),
                    SizedBox(height: 10.h),
                    ...result.medications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return PrescriptionMedicationCard(
                          index: index, medication: med);
                    }),
                    SizedBox(height: 20.h),
                    PrescriptionGeneralAdviceCard(
                        generalAdvice: result.generalAdvice),
                    SizedBox(height: 20.sp),
                    PrescriptionMessageCard(message: result.message),
                    SizedBox(height: 10.h),
                    PrescriptionWarningCard(warning: result.warning),
                  ] else if (type == 'lab') ...[
                    Text(
                      'نتائج المختبرات:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    const Text('هذه ميزة تحت الإنشاء - سيعرض التحليل قريبًا!'),
                  ] else if (type == 'child') ...[
                    Text(
                      'تحليل حالة الطفل:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
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
