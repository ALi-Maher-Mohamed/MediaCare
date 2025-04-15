import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/doctors_offers/data/model/offer_group_model.dart';

abstract class OfferGroupDetailsState extends Equatable {
  const OfferGroupDetailsState();

  @override
  List<Object> get props => [];
}

class OfferGroupDetailsInitial extends OfferGroupDetailsState {}

class OfferGroupDetailsLoading extends OfferGroupDetailsState {}

class OfferGroupDetailsLoaded extends OfferGroupDetailsState {
  final OfferGroup offerGroup;

  const OfferGroupDetailsLoaded(this.offerGroup);

  @override
  List<Object> get props => [offerGroup];
}

class OfferGroupDetailsError extends OfferGroupDetailsState {
  final String message;

  const OfferGroupDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
