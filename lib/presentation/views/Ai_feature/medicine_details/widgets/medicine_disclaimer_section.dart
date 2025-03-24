import 'package:flutter/material.dart';

class MedicineDisclaimerSection extends StatelessWidget {
  final String? disclaimer;

  const MedicineDisclaimerSection({super.key, this.disclaimer});

  @override
  Widget build(BuildContext context) {
    return Text(
      disclaimer ?? 'لا توجد إخلاء مسؤولية',
      style: const TextStyle(fontStyle: FontStyle.italic),
    );
  }
}
