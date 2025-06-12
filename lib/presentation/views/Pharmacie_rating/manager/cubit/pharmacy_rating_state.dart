import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/model/pharmacy_rating_model.dart';

abstract class PharmacyRatingState extends Equatable {
  const PharmacyRatingState();

  @override
  List<Object> get props => [];
}

class PharmacyRatingInitial extends PharmacyRatingState {}

class PharmacyRatingLoading extends PharmacyRatingState {}

class PharmacyRatingSuccess extends PharmacyRatingState {
  final PharmacyRatingModel pharmacyRatingModel;

  const PharmacyRatingSuccess(this.pharmacyRatingModel);

  @override
  List<Object> get props => [pharmacyRatingModel];
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
