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
          label: Text(
            'تحليل الأعراض',
            style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
          ),
          selected: isSymptom,
          onSelected: (selected) {
            onSymptomSelected(true);
          },
          selectedColor: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.2), // لون مختار من الثيم
          backgroundColor:
              Theme.of(context).colorScheme.surface, // خلفية من الثيم
        ),
        SizedBox(width: 10.w),
        ChoiceChip(
          label: Text(
            'تفاصيل الدواء',
            style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
          ),
          selected: !isSymptom,
          onSelected: (selected) {
            onSymptomSelected(false);
          },
          selectedColor: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.2), // لون مختار من الثيم
          backgroundColor:
              Theme.of(context).colorScheme.surface, // خلفية من الثيم
        ),
      ],
    );
  }
}
