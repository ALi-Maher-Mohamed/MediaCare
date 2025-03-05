import 'package:bloc/bloc.dart';
import '../../data/model/labs_model/data.dart';
import '../../data/services/laps_service.dart';
import 'labs_state.dart';

class LaboratoryCubit extends Cubit<LaboratoryState> {
  final LaboratoryService laboratoryService;
  int currentPage = 1;
  bool hasMore = true;
  bool isLoading = false;
  final Map<int, List<LaboratoryModel>> cachedPages = {};

  LaboratoryCubit(this.laboratoryService) : super(LaboratoryInitial());

  void fetchLaboratories(
      {bool isNextPage = false, bool isPrevPage = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (isNextPage) {
      currentPage++;
    } else if (isPrevPage && currentPage > 1) {
      currentPage--;
    }

    if (cachedPages.containsKey(currentPage)) {
      emit(LaboratorySuccessState(
        laboratories: cachedPages[currentPage]!,
        currentPage: currentPage,
        hasMore: hasMore,
      ));
      isLoading = false;
      return;
    }

    try {
      final pagination = await laboratoryService.fetchLaboratories(currentPage);
      cachedPages[currentPage] = pagination.laboratories;
      hasMore = pagination.laboratories.isNotEmpty;
      emit(LaboratorySuccessState(
        laboratories: pagination.laboratories,
        currentPage: currentPage,
        hasMore: hasMore,
      ));
    } catch (e) {
      emit(LaboratoryError(e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
