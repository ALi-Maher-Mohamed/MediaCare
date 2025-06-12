import 'package:flutter/material.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/Reservation/data/repo/reservation_repo.dart';
import 'package:media_care/presentation/views/Reservation/manager/cubit/reservation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationCubit extends Cubit<ReservationStates> {
  final ReservaionRepo reservaionRepo;
  ReservationCubit({required this.reservaionRepo})
      : super(ReservationStatesInitial());

  static ReservationCubit of(BuildContext context) =>
      BlocProvider.of<ReservationCubit>(context);

  bool isLoading = false;
  Future<void> reserveAppointment({
    required String userId,
    required String doctorId,
    required String clinicId,
    required int appointmentId,
    required String status,
  }) async {
    emit(ReservationStatesLoading());

    String? token = await SharedPreference().getToken();
    if (token == null || token.isEmpty) {
      emit(ReservationStatesError("Authentication failed: Missing token."));
      return;
    }

    final result = await reservaionRepo.reserve_appointment(
      user_id: userId,
      doctor_id: doctorId,
      clinic_id: clinicId,
      appointment_id: appointmentId,
      status: status,
      token: token.trim(),
    );

    result.fold(
      (failure) => emit(ReservationStatesError(failure.errMessage)),
      (reservation) =>
          emit(ReservationStatesDone(reservaion_model: reservation)),
    );
  }
}
