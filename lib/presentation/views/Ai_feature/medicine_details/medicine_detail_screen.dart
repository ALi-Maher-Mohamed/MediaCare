import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/manager/cubit/medicine_detail_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/manager/cubit/medicine_detail_state.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo_impl.dart';

class MedicineDetailScreen extends StatelessWidget {
  final String medicineName;

  const MedicineDetailScreen({required this.medicineName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MedicineDetailCubit(MedicineDetailRepositoryImpl(Dio()))
            ..fetchMedicineDetails(medicineName),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Text(
            'تفاصيل الدواء',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<MedicineDetailCubit, MedicineDetailState>(
          builder: (context, state) {
            if (state is MedicineDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MedicineDetailFailure) {
              return Center(child: Text(state.errorMessage));
            } else if (state is MedicineDetailSuccess) {
              final medicine = state.medicineDetail;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.medicineName ?? 'غير محدد',
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'الاسم العربي: ${medicine.medicineNameArabic ?? 'غير محدد'}',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'الاستطبابات:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.indications?.map((ind) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h),
                              child: Text('• $ind'),
                            )) ??
                        [const Text('لا توجد استطبابات')],
                    SizedBox(height: 20.h),
                    Text(
                      'تعليمات الجرعة:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(medicine.dosageInstructions ?? 'غير محدد'),
                    SizedBox(height: 20.h),
                    Text(
                      'الآثار الجانبية:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.sideEffects?.map((effect) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h),
                              child: Text('• $effect'),
                            )) ??
                        [const Text('لا توجد آثار جانبية')],
                    SizedBox(height: 20.h),
                    Text(
                      'الاحتياطات:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.precautions?.map((precaution) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h),
                              child: Text('• $precaution'),
                            )) ??
                        [const Text('لا توجد احتياطات')],
                    SizedBox(height: 20.h),
                    Text(
                      'معلومات إضافية:',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.additionalInformation?.map((info) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h),
                              child: Text('• $info'),
                            )) ??
                        [const Text('لا توجد معلومات إضافية')],
                    SizedBox(height: 20.h),
                    Text(
                      medicine.disclaimer ?? 'لا توجد إخلاء مسؤولية',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('يرجى الانتظار'));
          },
        ),
      ),
    );
  }
}
