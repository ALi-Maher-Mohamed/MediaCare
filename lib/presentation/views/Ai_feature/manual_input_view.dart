import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_state.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/symptom_result_screen.dart';

class ManualInputView extends StatefulWidget {
  @override
  _ManualInputViewState createState() => _ManualInputViewState();
}

class _ManualInputViewState extends State<ManualInputView> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        centerTitle: true,
        title: Text('بحث يدوي',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold)),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اكتب هنا:',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'أدخل الأعراض أو اسم الدواء',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20.h),
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
                SizedBox(width: 10.w),
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
            SizedBox(height: 20.h),
            Center(
              child: BlocConsumer<SymptomAnalysisCubit, SymptomAnalysisState>(
                listener: (context, state) {
                  if (state is SymptomAnalysisLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'جاري التحليل...',
                          style: TextStyle(color: AppColors.primary),
                        ),
                        backgroundColor: Colors.white,
                      ),
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
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0.h, horizontal: 32.0.w),
                    ),
                    child: Text(
                      'بحث',
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
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
