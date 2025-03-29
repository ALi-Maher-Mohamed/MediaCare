import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: Theme.of(context).colorScheme.outline,
                  thickness: 1.0,
                ),
                Text(
                  'معلومات الحجز:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'برجاء التسجيل الدخول للحجز',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // Add login navigation here
                        },
                        child: Text(
                          'سجل الآن',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    SizedBox(width: 5),
                    Text(
                      '$appointment_time',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: 5),
                    Text(
                      '$clinicTitle',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
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
                  color: Theme.of(context).colorScheme.error,
                ),
                child: Text(
                  'إلغاء',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onError,
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
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'احجز',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              onTap: () {
                final reservationCubit =
                    BlocProvider.of<ReservationCubit>(context);
                if (user_id == null ||
                    doctor_id == null ||
                    clinic_id == null ||
                    appointment_id == null) {
                  EasyLoading.showError("Missing required information");
                  return;
                }
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
