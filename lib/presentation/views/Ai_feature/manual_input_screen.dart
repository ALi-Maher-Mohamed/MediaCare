import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_state.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/symptom_result_screen.dart';

class ManualInputScreen extends StatefulWidget {
  @override
  _ManualInputScreenState createState() => _ManualInputScreenState();
}

class _ManualInputScreenState extends State<ManualInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSymptom = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بحث يدوي'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'اكتب هنا:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'أدخل الأعراض أو اسم الدواء',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('تحليل الأعراض'),
                  selected: _isSymptom,
                  onSelected: (selected) {
                    setState(() {
                      _isSymptom = true;
                    });
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('تفاصيل الدواء'),
                  selected: !_isSymptom,
                  onSelected: (selected) {
                    setState(() {
                      _isSymptom = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: BlocConsumer<SymptomAnalysisCubit, SymptomAnalysisState>(
                listener: (context, state) {
                  if (state is SymptomAnalysisLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('جاري التحليل...')),
                    );
                  } else if (state is SymptomAnalysisSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SymptomResultScreen(type: 'symptom'),
                      ),
                    );
                  } else if (state is SymptomAnalysisFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is SymptomAnalysisLoading
                        ? null
                        : () {
                            final input = _controller.text.trim();
                            if (input.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('يرجى إدخال نص')),
                              );
                              return;
                            }
                            if (_isSymptom) {
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
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                    ),
                    child: const Text(
                      'بحث',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
