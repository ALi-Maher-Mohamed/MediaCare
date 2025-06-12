import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/laboratories_rating/data/models/laboratory_rating_model.dart';

abstract class LaboratoryRatingState extends Equatable {
  const LaboratoryRatingState();

  @override
  List<Object> get props => [];
}

class LaboratoryRatingInitial extends LaboratoryRatingState {}

class LaboratoryRatingLoading extends LaboratoryRatingState {}

class LaboratoryRatingSuccess extends LaboratoryRatingState {
  final LaboratoryRatingModel laboratoryRatingModel;

  const LaboratoryRatingSuccess(this.laboratoryRatingModel);

  @override
  List<Object> get props => [laboratoryRatingModel];
}

class LaboratoryRatingError extends LaboratoryRatingState {
  final String message;

  const LaboratoryRatingError(this.message);

  @override
  List<Object> get props => [message];
}

class LaboratoryRatingUpdated extends LaboratoryRatingState {
  final int rating;

  const LaboratoryRatingUpdated(this.rating);

  @override
  List<Object> get props => [rating];
}

class LaboratoryRatingReviewUpdated extends LaboratoryRatingState {
  final String review;

  const LaboratoryRatingReviewUpdated(this.review);

  @override
  List<Object> get props => [review];
}
