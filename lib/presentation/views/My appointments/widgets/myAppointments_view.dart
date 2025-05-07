import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/My%20appointments/data/repo/appointments_repo_impl.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/appointments_cubit.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/appointments_state.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/cancel_cubit.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/cancel_state.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/cofirm_cubit.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/confirm_state.dart';
import 'package:media_care/presentation/views/My%20appointments/widgets/appointment_item.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentsRepo = MyAppointmentsRepoImpl(ApiServiceFunctions(Dio()));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MyAppointmentsCubit(appointmentsRepo: appointmentsRepo)
                ..fetchAppointments(),
        ),
        BlocProvider(
          create: (context) =>
              CancelAppointmentCubit(myAppointmentsRepo: appointmentsRepo),
        ),
        BlocProvider(
          create: (context) =>
              ConfirmAppointmentCubit(myAppointmentsRepo: appointmentsRepo),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          title: Text('حجوزاتي'),
          titleSpacing: -15,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<CancelAppointmentCubit, CancelAppointmentStates>(
              listener: (context, state) {
                if (state is CancelAppointmentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
                if (state is CancelAppointmentDone) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "تم الإلغاء بنجاح",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<MyAppointmentsCubit>().fetchAppointments();
                }
              },
            ),
            BlocListener<ConfirmAppointmentCubit, ConfirmAppointmentStates>(
              listener: (context, state) {
                if (state is ConfirmAppointmentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
                if (state is ConfirmAppointmentDone) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "تم التأكيد بنجاح",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<MyAppointmentsCubit>().fetchAppointments();
                }
              },
            ),
          ],
          child: BlocConsumer<MyAppointmentsCubit, MyAppointmentsState>(
            listener: (context, state) {
              if (state is MyAppointmentsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is MyAppointmentsInitial) {
                return const Center(child: Text('Initial state'));
              } else if (state is MyAppointmentsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MyAppointmentsLoaded) {
                if (state.appointment.data == null ||
                    state.appointment.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد مواعيد محجوزة',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: state.appointment.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AppointmentItem(
                      doctorName:
                          state.appointment.data?[index].doctor?.fName ?? '',
                      InfoAboutDoctor: state.appointment.data?[index].doctor
                              ?.infoAboutDoctor ??
                          '',
                      clinicName:
                          state.appointment.data?[index].clinic?.title ?? '',
                      clinicAddress:
                          state.appointment.data?[index].clinic?.address ?? '',
                      startTime:
                          state.appointment.data?[index].appointment?.startAt ??
                              '',
                      endTime:
                          state.appointment.data?[index].appointment?.endAt ??
                              '',
                      cancelReservation: () {
                        context
                            .read<CancelAppointmentCubit>()
                            .cancelAppointment(
                              id: state.appointment.data?[index].id ?? '',
                            );
                      },
                      confirmReservation: () {
                        context
                            .read<ConfirmAppointmentCubit>()
                            .confirmAppointment(
                              id: state.appointment.data?[index].id ?? '',
                            );
                      },
                    );
                  },
                );
              }
              return const Center(child: Text('Unexpected state'));
            },
          ),
        ),
      ),
    );
  }
}
