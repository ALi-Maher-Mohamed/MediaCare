import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/medicine_detail_screen.dart';

class PrescriptionMedicationCard extends StatelessWidget {
  final int index;
  final dynamic medication;

  const PrescriptionMedicationCard({
    super.key,
    required this.index,
    required this.medication,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface, // خلفية من الثيم
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicineDetailScreen(
                medicineName: medication.name ?? 'غير محدد',
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
                'الدواء ${index + 1}: ${medication.name ?? 'غير محدد'}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16.sp,
                      color:
                          Theme.of(context).colorScheme.primary, // لون من الثيم
                    ), // نمط من الثيم
              ),
              SizedBox(height: 5.h),
              Text(
                'الجرعة: ${medication.dosage ?? 'غير محدد'}',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
              Text(
                'التكرار: ${medication.frequency ?? 'غير محدد'}',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
              Text(
                'المدة: ${medication.duration ?? 'غير محدد'}',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
              Text(
                'الغرض: ${medication.purpose ?? 'غير محدد'}',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
              Text(
                'تحذيرات: ${medication.warnings ?? 'لا توجد تحذيرات'}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.redAccent), // نمط من الثيم مع لون مخصص
              ),
            ],
          ),
        ),
      ),
    );
  }
}
