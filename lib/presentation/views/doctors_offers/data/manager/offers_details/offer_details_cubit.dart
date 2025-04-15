import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/offers_details/offer_details_state.dart';
import 'package:media_care/presentation/views/doctors_offers/data/repos/offer_group_repository.dart';

class OfferGroupDetailsCubit extends Cubit<OfferGroupDetailsState> {
  final OfferGroupRepository repository;

  OfferGroupDetailsCubit(this.repository) : super(OfferGroupDetailsInitial());

  Future<void> fetchOfferGroupDetails(String id) async {
    emit(OfferGroupDetailsLoading());
    final result = await repository.getOfferGroupDetails(id);
    result.fold(
      (error) => emit(OfferGroupDetailsError(error)),
      (response) => emit(OfferGroupDetailsLoaded(response.data)),
    );
  }
}
