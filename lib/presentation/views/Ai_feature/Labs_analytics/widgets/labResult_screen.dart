import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_state.dart';

class LabAnalysisResultScreen extends StatelessWidget {
  final String type;

  const LabAnalysisResultScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتيجة تحليل $type'),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<LabAnalysisCubit, LabAnalysisState>(
        builder: (context, state) {
          if (state is LabAnalysisLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LabAnalysisFailure) {
            print(state.errorMessage);
            return Center(child: Text(state.errorMessage));
          } else if (state is LabAnalysisSuccess) {
            final result = state.analysisData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'lab') ...[
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.science, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'نتائج الاختبارات:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...result.testResults.asMap().entries.map((entry) {
                      final index = entry.key;
                      final test = entry.value;
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اختبار ${index + 1}: ${test.name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text('القيمة: ${test.value}'),
                              Text('الوحدة: ${test.unit}'),
                              Text('الحالة: ${test.status}'),
                              Text(
                                'ملاحظات: ${test.notes}',
                                style: TextStyle(
                                  color: (test.status?.toLowerCase() ==
                                          'غير طبيعي')
                                      ? Colors.redAccent
                                      : Colors.green,
                                ),
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
                                  'التفسير:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(result.interpretation ?? 'لا توجد تفسير'),
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
                                Icon(Icons.recommend, color: Colors.teal),
                                SizedBox(width: 8),
                                Text(
                                  'التوصيات:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ...?result.recommendations?.map((rec) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(rec ?? 'لا توجد توصيات'),
                                    )) ??
                                [const Text('لا توجد توصيات')],
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
                              result.warning ?? 'لا يوجد تحذير',
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
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
