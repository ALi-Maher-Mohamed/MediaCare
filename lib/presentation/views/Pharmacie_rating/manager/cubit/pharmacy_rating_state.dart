import 'package:equatable/equatable.dart';

abstract class PharmacyRatingState extends Equatable {
  const PharmacyRatingState();

  @override
  List<Object> get props => [];
}

class PharmacyRatingInitial extends PharmacyRatingState {}

class PharmacyRatingLoading extends PharmacyRatingState {}

class PharmacyRatingSuccess extends PharmacyRatingState {
  final String review;
  final int ratingValue;

  const PharmacyRatingSuccess({
    required this.review,
    required this.ratingValue,
  });

  @override
  List<Object> get props => [review, ratingValue];
}

class PharmacyRatingError extends PharmacyRatingState {
  final String message;

  const PharmacyRatingError(this.message);

  @override
  List<Object> get props => [message];
}

class PharmacyRatingUpdated extends PharmacyRatingState {
  final int rating;

  const PharmacyRatingUpdated(this.rating);

  @override
  List<Object> get props => [rating];
}

class PharmacyRatingReviewUpdated extends PharmacyRatingState {
  final String review;

  const PharmacyRatingReviewUpdated(this.review);

  @override
  List<Object> get props => [review];
}
