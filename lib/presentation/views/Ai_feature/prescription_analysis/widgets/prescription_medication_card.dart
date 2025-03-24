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
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MedicineDetailScreen(
            medicineName: medication.name ?? 'Unknown',
          ),
        ),
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'الدواء ${index + 1}: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineDetailScreen(
                            medicineName: medication.name ?? 'Unknown',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      medication.name ?? 'Unknown',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text('الجرعة: ${medication.dosage ?? 'غير محدد'}'),
              Text('التكرار: ${medication.frequency ?? 'غير محدد'}'),
              Text('المدة: ${medication.duration ?? 'غير محدد'}'),
              Text('الغرض: ${medication.purpose ?? 'غير محدد'}'),
              Text(
                'تحذيرات: ${medication.warnings ?? 'لا توجد تحذيرات'}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
