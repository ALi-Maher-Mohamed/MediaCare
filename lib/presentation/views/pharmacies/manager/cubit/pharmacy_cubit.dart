import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyRepo pharmacyRepo;
  int currentPage = 1;
  bool hasMore = true;

  PharmacyCubit(this.pharmacyRepo) : super(PharmacyInitial());
  void fetchPharmacies({bool isLoadMore = false}) async {
    if (!hasMore && isLoadMore) return;

    if (!isLoadMore) {
      currentPage = 1;
      emit(PharmacyLoadingState());
    }

    final result = await pharmacyRepo.getPharmacies(page: currentPage);
    result.fold(
      (failure) => emit(PharmacyErrorState(failure.errMessage)),
      (pharmacies) {
        if (isLoadMore && state is PharmacySuccessState) {
          final currentState = state as PharmacySuccessState;
          final updatedList = [...currentState.pharmacies, ...pharmacies];
          final updatedOriginal = [
            ...currentState.allPharmacies,
            ...pharmacies
          ];

          emit(PharmacySuccessState(updatedList, updatedOriginal));
        } else {
          emit(PharmacySuccessState(pharmacies, pharmacies));
        }

        hasMore = pharmacies.length == 6; // per_page = 6
        if (hasMore) currentPage++;
      },
    );
  }

  void searchPharmacies(String query) {
    if (state is! PharmacySuccessState) return;

    final currentState = state as PharmacySuccessState;

    if (query.isEmpty) {
      emit(PharmacySuccessState(
          currentState.allPharmacies, currentState.allPharmacies));
    } else {
      final filtered = currentState.allPharmacies.where((pharmacy) {
        return pharmacy.title.toLowerCase().contains(query.toLowerCase()) ||
            pharmacy.city.toLowerCase().contains(query.toLowerCase()) ||
            pharmacy.area.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(PharmacySuccessState(filtered, currentState.allPharmacies));
    }
  }
}
