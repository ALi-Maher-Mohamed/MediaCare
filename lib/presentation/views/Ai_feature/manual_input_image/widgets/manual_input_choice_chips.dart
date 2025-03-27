import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManualInputChoiceChips extends StatelessWidget {
  final bool isSymptom;
  final ValueChanged<bool> onSymptomSelected;

  const ManualInputChoiceChips({
    super.key,
    required this.isSymptom,
    required this.onSymptomSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text('تحليل الأعراض'),
          selected: isSymptom,
          onSelected: (selected) {
            onSymptomSelected(true);
          },
        ),
        SizedBox(width: 10.w),
        ChoiceChip(
          label: const Text('تفاصيل الدواء'),
          selected: !isSymptom,
          onSelected: (selected) {
            onSymptomSelected(false);
          },
        ),
      ],
    );
  }
}
