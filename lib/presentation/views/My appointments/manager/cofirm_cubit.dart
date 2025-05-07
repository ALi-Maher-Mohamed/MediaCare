import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/My%20appointments/data/repo/appointments_repo.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/confirm_state.dart';

class ConfirmAppointmentCubit extends Cubit<ConfirmAppointmentStates> {
  final MyAppointmentsRepo myAppointmentsRepo;

  ConfirmAppointmentCubit({required this.myAppointmentsRepo})
      : super(ConfirmAppointmentInitial());

  Future<void> confirmAppointment({required String id}) async {
    emit(ConfirmAppointmentLoading());

    try {
      String? token = await SharedPreference().getToken();
      if (token == null || token.isEmpty) {
        emit(ConfirmAppointmentError("Authentication failed: Missing token."));
        return;
      }

      final result = await myAppointmentsRepo.confirmAppointment(
        token: token.trim(),
        id: id.trim(),
      );

      result.fold(
        (failure) => emit(ConfirmAppointmentError(failure.errMessage)),
        (confirmModel) =>
            emit(ConfirmAppointmentDone(confirmModel: confirmModel)),
      );
    } catch (e) {
      emit(ConfirmAppointmentError(e.toString()));
    }
  }
}
