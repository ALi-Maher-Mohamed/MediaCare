import 'package:bloc/bloc.dart';
import '../../data/model/pharmacy_model.dart';
import '../../data/service/pharmacy_service.dart';
import 'package:meta/meta.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyService pharmacyService;
  int currentPage = 1;
  bool hasNextPage = true;
  bool isLoading = false;
  final Map<int, List<PharmacyModel>> cachedPages = {};

  PharmacyCubit(this.pharmacyService) : super(PharmacyInitial());

  void fetchPharmacies(
      {bool isNextPage = false, bool isPrevPage = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (isNextPage) {
      currentPage++;
    } else if (isPrevPage && currentPage > 1) {
      currentPage--;
    }

    if (cachedPages.containsKey(currentPage)) {
      emit(PharmacySuccessState(
          cachedPages[currentPage]!, currentPage, hasNextPage));
      isLoading = false;
      return;
    }

    try {
      final pagination =
          await pharmacyService.fetchPharmacies(page: currentPage);
      cachedPages[currentPage] = pagination.pharmacies;
      hasNextPage = pagination.pharmacies.isNotEmpty;
      emit(PharmacySuccessState(
          pagination.pharmacies, currentPage, hasNextPage));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
