import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Ai_feature/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/Ai_feature/manager/cubit/prescription_state.dart';

class ResultScreen extends StatelessWidget {
  final String type;

  const ResultScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتيجة تحليل $type'),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<AnalysisCubit, AnalysisState>(
        builder: (context, state) {
          if (state is AnalysisLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnalysisFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is AnalysisSuccess) {
            final result = state.analysisData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'prescription') ...[
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.info, color: Colors.teal),
                                SizedBox(width: 8),
                                Text(
                                  'تفاصيل الروشتة:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                                'اسم الطبيب: ${result.prescriptionDetails.doctorName}'),
                            Text(
                                'اسم المريض: ${result.prescriptionDetails.patientName}'),
                            Text(
                                'عمر المريض: ${result.prescriptionDetails.patientAge}'),
                            Text(
                                'تاريخ الروشتة: ${result.prescriptionDetails.prescriptionDate}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.medical_services, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'الأدوية:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...result.medications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الدواء ${index + 1}: ${med.name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text('الجرعة: ${med.dosage}'),
                              Text('التكرار: ${med.frequency}'),
                              Text('المدة: ${med.duration}'),
                              Text('الغرض: ${med.purpose}'),
                              Text(
                                'تحذيرات: ${med.warnings}',
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.lightbulb, color: Colors.teal),
                                SizedBox(width: 8),
                                Text(
                                  'النصائح العامة:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ...result.generalAdvice.entries
                                .map((entry) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        '${entry.key}: ${entry.value}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.message, color: Colors.teal),
                                SizedBox(width: 8),
                                Text(
                                  'رسالة:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(result.message ?? ''),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.warning, color: Colors.redAccent),
                                SizedBox(width: 8),
                                Text(
                                  'تحذير:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              result.warning ?? "",
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (type == 'lab') ...[
                    const Text('نتائج المختبرات:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text('هذه ميزة تحت الإنشاء - سيعرض التحليل قريبًا!'),
                  ] else if (type == 'child') ...[
                    const Text('تحليل حالة الطفل:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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
