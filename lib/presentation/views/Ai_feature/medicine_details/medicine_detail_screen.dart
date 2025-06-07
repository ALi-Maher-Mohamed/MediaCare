import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/pdf_helper.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/manager/cubit/medicine_detail_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_name_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_indications_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_dosage_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_side_effects_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_precautions_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_additional_info_section.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/widgets/medicine_disclaimer_section.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart'; // تأكد من مسار ملف PdfHelper

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: Theme.of(context).appBarTheme.elevation,
          centerTitle: true,
          title: Text(
            'تفاصيل الدواء',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 24.sp),
          ),
          actions: [
            BlocBuilder<MedicineDetailCubit, AiState>(
              builder: (context, state) {
                if (state is AiSuccess && state.type == AnalysisType.medicine) {
                  final medicine = state.result as MedicineDetail;
                  return IconButton(
                    icon: Icon(Icons.picture_as_pdf),
                    tooltip: 'تحميل ملف PDF',
                    onPressed: () async {
                      final pdf = await PdfHelper.createPdf(medicine);
                      final bytes = await pdf.save();

                      await Printing.layoutPdf(
                        onLayout: (PdfPageFormat format) async => bytes,
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
        body: BlocBuilder<MedicineDetailCubit, AiState>(
          builder: (context, state) {
            if (state is AiLoading && state.type == AnalysisType.medicine) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (state is AiFailure &&
                state.type == AnalysisType.medicine) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            } else if (state is AiSuccess &&
                state.type == AnalysisType.medicine) {
              final medicine = state.result as MedicineDetail;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MedicineNameSection(
                      medicineName: medicine.medicineName ?? 'غير معروف',
                      medicineNameArabic: medicine.medicineNameArabic,
                    ),
                    SizedBox(height: 20.h),
                    if (medicine.indications != null &&
                        medicine.indications!.isNotEmpty)
                      MedicineIndicationsSection(
                          indications: medicine.indications!),
                    SizedBox(height: 20.h),
                    if (medicine.dosageInstructions != null)
                      MedicineDosageSection(
                          dosageInstructions: medicine.dosageInstructions!),
                    SizedBox(height: 20.h),
                    if (medicine.sideEffects != null &&
                        medicine.sideEffects!.isNotEmpty)
                      MedicineSideEffectsSection(
                          sideEffects: medicine.sideEffects!),
                    SizedBox(height: 20.h),
                    if (medicine.precautions != null &&
                        medicine.precautions!.isNotEmpty)
                      MedicinePrecautionsSection(
                          precautions: medicine.precautions!),
                    SizedBox(height: 20.h),
                    if (medicine.additionalInformation != null &&
                        medicine.additionalInformation!.isNotEmpty)
                      MedicineAdditionalInfoSection(
                          additionalInformation:
                              medicine.additionalInformation!),
                    SizedBox(height: 20.h),
                    if (medicine.disclaimer != null)
                      MedicineDisclaimerSection(
                          disclaimer: medicine.disclaimer!),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                'يرجى الانتظار',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        ),
      ),
    );
  }
}
