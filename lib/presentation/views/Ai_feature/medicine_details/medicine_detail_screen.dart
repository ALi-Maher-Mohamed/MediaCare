import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/manager/cubit/medicine_detail_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_name_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_indications_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_dosage_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_side_effects_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_precautions_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_additional_info_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_disclaimer_section.dart';

class MedicineDetailScreen extends StatelessWidget {
  final String medicineName;

  const MedicineDetailScreen({required this.medicineName, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MedicineDetailCubit(MedicineDetailRepositoryImpl(Dio()))
            ..fetchMedicineDetails(medicineName),
      child: Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor, // توافق مع الثيم
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: Theme.of(context).appBarTheme.elevation,
          centerTitle: true,
          title: Text(
            'تفاصيل الدواء',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 24.sp,
                ), // نمط من الثيم
          ),
        ),
        body: BlocBuilder<MedicineDetailCubit, AiState>(
          builder: (context, state) {
            if (state is AiLoading && state.type == AnalysisType.medicine) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary, // لون من الثيم
                ),
              );
            } else if (state is AiFailure &&
                state.type == AnalysisType.medicine) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                ),
              );
            } else if (state is AiSuccess &&
                state.type == AnalysisType.medicine) {
              final medicine = state.result;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MedicineNameSection(
                      medicineName: medicine.medicineName ?? 'غير محدد',
                      medicineNameArabic: medicine.medicineNameArabic,
                    ),
                    SizedBox(height: 20.h),
                    MedicineIndicationsSection(
                        indications: medicine.indications),
                    SizedBox(height: 20.h),
                    MedicineDosageSection(
                        dosageInstructions: medicine.dosageInstructions),
                    SizedBox(height: 20.h),
                    MedicineSideEffectsSection(
                        sideEffects: medicine.sideEffects),
                    SizedBox(height: 20.h),
                    MedicinePrecautionsSection(
                        precautions: medicine.precautions),
                    SizedBox(height: 20.h),
                    MedicineAdditionalInfoSection(
                        additionalInformation: medicine.additionalInformation),
                    SizedBox(height: 20.h),
                    MedicineDisclaimerSection(disclaimer: medicine.disclaimer),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                'يرجى الانتظار',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            );
          },
        ),
      ),
    );
  }
}
