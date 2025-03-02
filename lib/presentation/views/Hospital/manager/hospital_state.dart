import 'package:equatable/equatable.dart';
import '../data/models/hospital_model.dart';

abstract class HospitalState extends Equatable {
  const HospitalState();

  @override
  List<Object> get props => [];
}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final HospitalModel hospitalModel;

  const HospitalLoaded(this.hospitalModel);

  @override
  List<Object> get props => [hospitalModel];
}

class HospitalError extends HospitalState {
  final String message;

  const HospitalError(this.message);

  @override
  List<Object> get props => [message];
}