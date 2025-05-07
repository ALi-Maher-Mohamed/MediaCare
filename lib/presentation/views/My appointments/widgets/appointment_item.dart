import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentItem extends StatelessWidget {
  AppointmentItem({
    super.key,
    required this.doctorName,
    required this.InfoAboutDoctor,
    required this.clinicName,
    required this.clinicAddress,
    required this.startTime,
    required this.endTime,
    required this.confirmReservation,
    required this.cancelReservation,
  });

  final String? doctorName;
  final String? InfoAboutDoctor;
  final String? clinicName;
  final String? clinicAddress;
  final String? startTime;
  final String? endTime;
  final VoidCallback confirmReservation;
  final VoidCallback cancelReservation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'معلومات الحجز',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'الدكتور : $doctorName',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          // Text(
          //   'معلومات عن الدكتور : $InfoAboutDoctor',
          //   style: TextStyle(
          //     fontSize: 15.sp,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   overflow: TextOverflow.clip,
          // ),
          // SizedBox(height: 10.h),
          Text(
            'المكان : $clinicName',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'العنوان : $clinicAddress',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'يبدأ في : $startTime',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'ينتهي في : $endTime',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: cancelReservation,
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              ElevatedButton(
                onPressed: confirmReservation,
                child: const Text('تأكيد'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
