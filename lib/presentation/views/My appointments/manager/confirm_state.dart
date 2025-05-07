import 'package:equatable/equatable.dart';

import '../data/models/confirm_model.dart';



abstract class ConfirmAppointmentStates extends Equatable {
  const ConfirmAppointmentStates();

  @override
  List<Object> get props => [];
}

class ConfirmAppointmentInitial extends ConfirmAppointmentStates {}

class ConfirmAppointmentLoading extends ConfirmAppointmentStates {}

class ConfirmAppointmentDone extends ConfirmAppointmentStates {
  final ConfirmModel confirmModel;

  ConfirmAppointmentDone({
    required this.confirmModel,
  });

  @override
  List<Object> get props => [confirmModel];
}

class ConfirmAppointmentError extends ConfirmAppointmentStates {
  final String message;

  const ConfirmAppointmentError(this.message);

  @override
  List<Object> get props => [message];
}
