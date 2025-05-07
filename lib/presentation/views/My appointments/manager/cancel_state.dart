import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/cancel_model.dart';

abstract class CancelAppointmentStates extends Equatable {
  const CancelAppointmentStates();

  @override
  List<Object> get props => [];
}

class CancelAppointmentInitial extends CancelAppointmentStates {}

class CancelAppointmentLoading extends CancelAppointmentStates {}

class CancelAppointmentDone extends CancelAppointmentStates {
  final CancelModel cancelModel;

  CancelAppointmentDone({
    required this.cancelModel,
  });

  @override
  List<Object> get props => [cancelModel];
}

class CancelAppointmentError extends CancelAppointmentStates {
  final String message;

  const CancelAppointmentError(this.message);

  @override
  List<Object> get props => [message];
}
