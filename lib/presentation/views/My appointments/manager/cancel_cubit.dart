import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/My%20appointments/data/repo/appointments_repo.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/cancel_state.dart';

class CancelAppointmentCubit extends Cubit<CancelAppointmentStates> {
  final MyAppointmentsRepo myAppointmentsRepo;

  CancelAppointmentCubit({required this.myAppointmentsRepo})
      : super(CancelAppointmentInitial());

  Future<void> cancelAppointment({required String id}) async {
    emit(CancelAppointmentLoading());

    try {
      String? token = await SharedPreference().getToken();
      if (token == null || token.isEmpty) {
        emit(CancelAppointmentError("Authentication failed: Missing token."));
        return;
      }

      final result = await myAppointmentsRepo.cancelAppointment(
        token: token.trim(),
        id: id.trim(),
      );

      result.fold(
        (failure) => emit(CancelAppointmentError(failure.errMessage)),
        (cancelModel) => emit(CancelAppointmentDone(cancelModel: cancelModel)),
      );
    } catch (e) {
      emit(CancelAppointmentError(e.toString()));
    }
  }
}
