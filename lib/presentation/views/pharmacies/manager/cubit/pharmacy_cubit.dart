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
      (failure) => emit(PharmacyErrorState(
          failure.errMessage)), // نستخدم errMessage من Failure
      (pharmacies) {
        if (isLoadMore) {
          final currentPharmacies = (state as PharmacySuccessState).pharmacies;
          emit(PharmacySuccessState([...currentPharmacies, ...pharmacies]));
        } else {
          emit(PharmacySuccessState(pharmacies));
        }
        hasMore =
            pharmacies.length == 6; // افتراض أن per_page = 6 هو الحد الأقصى
        if (hasMore) currentPage++;
      },
    );
  }
}
