import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'labs_state.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/pagination_labs_model.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo.dart';

class LaboratoryCubit extends Cubit<LaboratoryState> {
  final LaboratoryRepo laboratoryRepo;
  int currentPage = 1;
  bool hasMore = true;
  final ScrollController scrollController = ScrollController();

  LaboratoryCubit(this.laboratoryRepo) : super(LaboratoryInitial()) {
    scrollController.addListener(_onScroll);
    fetchLaboratories();
  }

  void fetchLaboratories({bool isLoadMore = false}) async {
    if (!hasMore && isLoadMore) return;

    if (!isLoadMore) {
      currentPage = 1;
      emit(LaboratoryLoadingState());
    }

    final Either<Failure, LaboratoryPagination> result =
        await laboratoryRepo.getLaboratories(page: currentPage);

    result.fold(
      (failure) => emit(LaboratoryErrorState(failure.errMessage)),
      (pagination) {
        final labs = pagination.laboratories;

        if (isLoadMore && state is LaboratorySuccessState) {
          final currentState = state as LaboratorySuccessState;

          final updatedAllLabs = [...currentState.allLaboratories, ...labs];
          final updatedLabs = [...currentState.laboratories, ...labs];

          emit(LaboratorySuccessState(updatedLabs, updatedAllLabs));
        } else {
          emit(LaboratorySuccessState(labs, labs));
        }

        hasMore = labs.length == 6; // حسب حجم الصفحة (per_page)
        if (hasMore) currentPage++;
      },
    );
  }

  void searchLaboratories(String query) {
    if (state is! LaboratorySuccessState) return;

    final currentState = state as LaboratorySuccessState;

    if (query.isEmpty) {
      emit(LaboratorySuccessState(
          currentState.allLaboratories, currentState.allLaboratories));
    } else {
      final filteredLabs = currentState.allLaboratories.where((lab) {
        final q = query.toLowerCase();
        return lab.title.toLowerCase().contains(q) ||
            lab.city.toLowerCase().contains(q) ||
            lab.area.toLowerCase().contains(q);
      }).toList();

      emit(LaboratorySuccessState(filteredLabs, currentState.allLaboratories));
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchLaboratories(isLoadMore: true);
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
