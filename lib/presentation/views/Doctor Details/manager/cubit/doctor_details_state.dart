import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';

abstract class DoctorDetailsState extends Equatable {
  const DoctorDetailsState();

  @override
  List<Object> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsState {}

class DoctorDetailsLoading extends DoctorDetailsState {}

class DoctorDetailsLoaded extends DoctorDetailsState {
  final DoctorDetailsModel DoctorDetails;

  DoctorDetailsLoaded({
    required this.DoctorDetails,
  });

  @override
  List<Object> get props => [DoctorDetails];
}

class DoctorDetailsError extends DoctorDetailsState {
  final String message;

  const DoctorDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
