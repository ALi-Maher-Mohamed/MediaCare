import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Reservation/data/models/reservaion_model.dart';

abstract class ReservationStates extends Equatable {
  const ReservationStates();

  @override
  List<Object> get props => [];
}

class ReservationStatesInitial extends ReservationStates {}

class ReservationStatesLoading extends ReservationStates {}

class ReservationStatesDone extends ReservationStates {
  final ReservationModel reservaion_model;

  ReservationStatesDone({
    required this.reservaion_model,
  });

  @override
  List<Object> get props => [reservaion_model];
}

class ReservationStatesError extends ReservationStates {
  final String message;

  const ReservationStatesError(this.message);

  @override
  List<Object> get props => [message];
}
