import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/cubit/doctor_offers_state.dart';
import 'package:media_care/presentation/views/doctors_offers/data/repos/offer_group_repository.dart';

class OfferGroupCubit extends Cubit<OfferGroupState> {
  final OfferGroupRepository repository;
  int currentPage = 1;
  bool hasMoreData = true;

  OfferGroupCubit(this.repository) : super(OfferGroupInitial());

  Future<void> fetchOfferGroups({bool loadMore = false}) async {
    if (state is OfferGroupLoading && loadMore) return;
    if (!hasMoreData && loadMore) return;

    if (!loadMore) {
      currentPage = 1;
      hasMoreData = true;
      emit(OfferGroupLoading());
    } else {
      emit(OfferGroupLoadingMore(state.offerGroups));
    }

    final result = await repository.getOfferGroups(page: currentPage);
    result.fold(
      (error) => emit(OfferGroupError(error)),
      (response) {
        if (response.data.isEmpty) {
          hasMoreData = false;
          if (!loadMore) {
            emit(const OfferGroupLoaded([]));
          }
          return;
        }
        final newOfferGroups =
            loadMore ? [...state.offerGroups, ...response.data] : response.data;
        currentPage++;
        emit(OfferGroupLoaded(newOfferGroups));
      },
    );
  }
}
