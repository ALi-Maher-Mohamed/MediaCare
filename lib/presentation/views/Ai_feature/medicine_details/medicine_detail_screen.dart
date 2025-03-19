import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        appBar: AppBar(
          title: Text('تفاصيل الدواء'),
          backgroundColor: Colors.teal,
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
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'الاسم العربي: ${medicine.medicineNameArabic ?? 'غير محدد'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'الاستطبابات:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.indications?.map((ind) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('• $ind'),
                            )) ??
                        [const Text('لا توجد استطبابات')],
                    const SizedBox(height: 20),
                    const Text(
                      'تعليمات الجرعة:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(medicine.dosageInstructions ?? 'غير محدد'),
                    const SizedBox(height: 20),
                    const Text(
                      'الآثار الجانبية:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.sideEffects?.map((effect) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('• $effect'),
                            )) ??
                        [const Text('لا توجد آثار جانبية')],
                    const SizedBox(height: 20),
                    const Text(
                      'الاحتياطات:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.precautions?.map((precaution) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('• $precaution'),
                            )) ??
                        [const Text('لا توجد احتياطات')],
                    const SizedBox(height: 20),
                    const Text(
                      'معلومات إضافية:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...medicine.additionalInformation?.map((info) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('• $info'),
                            )) ??
                        [const Text('لا توجد معلومات إضافية')],
                    const SizedBox(height: 20),
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
