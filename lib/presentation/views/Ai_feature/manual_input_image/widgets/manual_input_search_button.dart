import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/symptom_result_screen.dart';

class ManualInputSearchButton extends StatelessWidget {
  final TextEditingController controller;
  final bool isSymptom;

  const ManualInputSearchButton({
    super.key,
    required this.controller,
    required this.isSymptom,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SymptomAnalysisCubit, AiState>(
      listener: (context, state) {
        if (state is AiLoading && state.type == AnalysisType.symptom) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'جاري التحليل...',
                style: TextStyle(color: AppColors.primary),
              ),
              backgroundColor: Colors.white,
            ),
          );
        } else if (state is AiSuccess && state.type == AnalysisType.symptom) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SymptomResultScreen(type: 'symptom'),
            ),
          );
        } else if (state is AiFailure && state.type == AnalysisType.symptom) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: (state is AiLoading && state.type == AnalysisType.symptom)
              ? null
              : () {
                  final input = controller.text.trim();
                  if (input.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال نص')),
                    );
                    return;
                  }
                  if (isSymptom) {
                    context
                        .read<SymptomAnalysisCubit>()
                        .analyzeSymptoms('symptom', {'text': input});
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicineDetailScreen(
                          medicineName: input,
                        ),
                      ),
                    );
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 32.0.w),
          ),
          child: Text(
            'بحث',
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        );
      },
    );
  }
}
