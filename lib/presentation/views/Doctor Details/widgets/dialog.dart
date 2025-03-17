import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Reservation/manager/cubit/reservation_cubit.dart';
import 'package:media_care/presentation/views/Reservation/manager/cubit/reservation_state.dart';

class ReservationDialog extends StatelessWidget {
  final String? full_name;
  final String? clinicTitle;
  final String? appointment_time;
  final String? appointment_id;
  final String? clinic_id;
  final String? doctor_id;
  final String? user_id;
  final String? status;

  const ReservationDialog({
    super.key,
    required this.full_name,
    required this.user_id,
    required this.doctor_id,
    required this.appointment_id,
    required this.clinic_id,
    required this.status,
    required this.clinicTitle,
    required this.appointment_time,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationStates>(
      listener: (context, state) {
        if (state is ReservationStatesDone) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Reservation Successful");
          Navigator.pop(context);
        } else if (state is ReservationStatesLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is ReservationStatesError) {
          EasyLoading.showError(state.message);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              'احجز الآن مع د. ${full_name}',
              style: TextStyle(
                color: Color(0xff0DCAF0),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                const Text(
                  'معلومات الحجز:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'برجاء التسجيل الدخول للحجز',
                        style: TextStyle(color: Colors.brown),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // Add login navigation here
                        },
                        child: const Text('سجل الآن'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey),
                    SizedBox(width: 5),
                    Text('$appointment_time'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 5),
                    Text('${clinicTitle}'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color.fromARGB(255, 242, 37, 37),
                ),
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xff0DCAF0),
                ),
                child: Text(
                  'احجز',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                final reservationCubit =
                    BlocProvider.of<ReservationCubit>(context);

                // Ensure all parameters are valid before calling the function
                if (user_id == null ||
                    doctor_id == null ||
                    clinic_id == null ||
                    appointment_id == null) {
                  EasyLoading.showError("Missing required information");
                  return;
                }
                // print('$user_id');
                // print('token : $g')
                reservationCubit.reserveAppointment(
                  userId: user_id!,
                  doctorId: doctor_id!,
                  clinicId: clinic_id!,
                  appointmentId: appointment_id!,
                  status: status ?? 'pending',
                );
              },
            ),
          ],
        );
      },
    );
  }
}
