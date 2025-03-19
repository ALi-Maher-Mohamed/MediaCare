import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_state.dart';

class SymptomResultScreen extends StatelessWidget {
  final String type;

  const SymptomResultScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتيجة تحليل الأعراض'),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
        builder: (context, state) {
          if (state is SymptomAnalysisLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SymptomAnalysisFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is SymptomAnalysisSuccess) {
            final result = state.analysisData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // التشخيص المحتمل
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              FaIcon(FontAwesomeIcons.diagnoses,
                                  color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'التشخيص المحتمل:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(result.diagnosis ?? 'غير محدد'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // التخصص الموصى به
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.local_hospital, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'التخصص الموصى به:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(result.recommendedSpecialization ?? 'غير محدد'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // النصيحة
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
                                'النصيحة:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(result.advice ?? 'لا توجد نصائح'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // درجة الثقة
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.score, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'درجة الثقة:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('${result.confidenceScore ?? 0}%'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // الرسالة
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(result.message ?? 'لا توجد رسالة'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // الأدوية المقترحة
                  const Row(
                    children: [
                      Icon(Icons.medical_services, color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        'الأدوية المقترحة:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (result.suggestedMedications.isNotEmpty)
                    ...result.suggestedMedications.asMap().entries.map((entry) {
                      final index = entry.key;
                      final med = entry.value;
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicineDetailScreen(
                                  medicineName: med.name ?? '',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الدواء ${index + 1}: ${med.name ?? 'غير محدد'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text('الجرعة: ${med.dosage ?? 'غير محدد'}'),
                                Text(
                                    'ملاحظات: ${med.notes ?? 'لا توجد ملاحظات'}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  else
                    const Text('لا توجد أدوية مقترحة'),
                  const SizedBox(height: 20),
                  // التحذير
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            result.medicationWarning ?? 'لا يوجد تحذير',
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
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
