import 'package:bloc/bloc.dart';
import '../../data/service/pharmacy_service.dart';
import 'package:meta/meta.dart';
import '../../data/model/pharmacy_model.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyService pharmacyService;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  final Map<int, List<PharmacyModel>> cachedPages = {};

  PharmacyCubit(this.pharmacyService) : super(PharmacyInitial());

  void fetchPharmacies(
      {bool isNextPage = false, bool isPrevPage = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (isNextPage) {
      if (!hasMore) {
        isLoading = false;
        return; // منع الانتقال لصفحة فارغة
      }
      currentPage++;
    } else if (isPrevPage && currentPage > 1) {
      currentPage--;
    }

    if (cachedPages.containsKey(currentPage)) {
      emit(PharmacySuccessState(
        pharmacies: cachedPages[currentPage]!,
        currentPage: currentPage,
        hasMore: hasMore,
      ));
      isLoading = false;
      return;
    }

    try {
      final pagination =
          await pharmacyService.fetchPharmacies(page: currentPage);
      hasMore = pagination
          .pharmacies.isNotEmpty; // تحديد ما إذا كانت هناك بيانات جديدة
      cachedPages[currentPage] = pagination.pharmacies;

      emit(PharmacySuccessState(
        pharmacies: pagination.pharmacies,
        currentPage: currentPage,
        hasMore: hasMore,
      ));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
