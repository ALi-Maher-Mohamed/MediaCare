import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Doctor_rating/data/model/doctor_rating_model.dart';

abstract class DoctorRatingState extends Equatable {
  const DoctorRatingState();

  @override
  List<Object> get props => [];
}

class DoctorRatingInitial extends DoctorRatingState {}

class DoctorRatingLoading extends DoctorRatingState {}

class DoctorRatingUpdated extends DoctorRatingState {
  final int rating;
  final String review;

  const DoctorRatingUpdated({required this.rating, required this.review});

  @override
  List<Object> get props => [rating, review];
}

class DoctorRatingSuccess extends DoctorRatingState {
  final DoctorRatingModel doctorRatingModel;

  const DoctorRatingSuccess(this.doctorRatingModel);

  @override
  List<Object> get props => [doctorRatingModel];
}

class DoctorRatingError extends DoctorRatingState {
  final String message;

  const DoctorRatingError(this.message);

  @override
  List<Object> get props => [message];
}
