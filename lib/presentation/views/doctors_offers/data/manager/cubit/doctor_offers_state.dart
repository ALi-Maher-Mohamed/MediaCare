import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/doctors_offers/data/model/offer_group_model.dart';

abstract class OfferGroupState extends Equatable {
  const OfferGroupState();

  @override
  List<Object> get props => [];

  get offerGroups => null;
}

class OfferGroupInitial extends OfferGroupState {}

class OfferGroupLoading extends OfferGroupState {}

class OfferGroupLoadingMore extends OfferGroupState {
  final List<OfferGroup> offerGroups;

  const OfferGroupLoadingMore(this.offerGroups);

  @override
  List<Object> get props => [offerGroups];
}

class OfferGroupLoaded extends OfferGroupState {
  final List<dynamic> offerGroups;

  const OfferGroupLoaded(this.offerGroups);

  @override
  List<Object> get props => [offerGroups];
}

class OfferGroupError extends OfferGroupState {
  final String message;

  const OfferGroupError(this.message);

  @override
  List<Object> get props => [message];
}
