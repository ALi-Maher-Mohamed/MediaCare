import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/appointments_model.dart';

abstract class MyAppointmentsState extends Equatable {
  const MyAppointmentsState();

  @override
  List<Object> get props => [];
}

class MyAppointmentsInitial extends MyAppointmentsState {}

class MyAppointmentsLoading extends MyAppointmentsState {}

class MyAppointmentsLoaded extends MyAppointmentsState {
  final myAppointmentsModel appointment;

  const MyAppointmentsLoaded(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class MyAppointmentsError extends MyAppointmentsState {
  final String message;

  const MyAppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}
