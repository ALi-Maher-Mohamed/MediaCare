import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/appointments_model.dart';
import 'package:media_care/presentation/views/My%20appointments/manager/appointments_state.dart';
import '../../../../core/SharedPref/shared_pref.dart';
import '../../../../core/errors/failure.dart';
import '../data/repo/appointments_repo_impl.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  final MyAppointmentsRepoImpl appointmentsRepo;

  MyAppointmentsCubit({
    required this.appointmentsRepo,
  }) : super(MyAppointmentsInitial());

  Future<void> fetchAppointments() async {
    emit(MyAppointmentsLoading());
    try {
      String? token = await SharedPreference().getToken();
      print('token = $token');
      if (token == null) {
        emit(MyAppointmentsError('No token found'));
        return;
      }
      Either<Failure, myAppointmentsModel> result =
          await appointmentsRepo.getAppointment(token: token);
      result.fold((failure) => emit(MyAppointmentsError(failure.errMessage)),
          (appointment) {
        emit(MyAppointmentsLoaded(appointment));
      });
    } catch (e) {
      emit(MyAppointmentsError(e.toString()));
    }
  }

  Future<void> confirmAppointment() async {
    emit(MyAppointmentsLoading());
    try {
      String? token = await SharedPreference().getToken();
      print('token = $token');
      if (token == null) {
        emit(MyAppointmentsError('No token found'));
        return;
      }
      Either<Failure, myAppointmentsModel> result =
          await appointmentsRepo.getAppointment(token: token);
      result.fold((failure) => emit(MyAppointmentsError(failure.errMessage)),
          (appointment) {
        emit(MyAppointmentsLoaded(appointment));
      });
    } catch (e) {
      emit(MyAppointmentsError(e.toString()));
    }
  }
}
