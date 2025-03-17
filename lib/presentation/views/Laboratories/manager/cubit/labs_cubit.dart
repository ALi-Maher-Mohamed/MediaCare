import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart'; // لاستخدام ScrollController
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/pagination_labs_model.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo.dart';
import '../../data/model/labs_model/data.dart';
import 'labs_state.dart';

class LaboratoryCubit extends Cubit<LaboratoryState> {
  final LaboratoryRepo laboratoryRepo;
  int currentPage = 1;
  bool hasMore = true;
  final ScrollController scrollController = ScrollController();

  LaboratoryCubit(this.laboratoryRepo) : super(LaboratoryInitial()) {
    scrollController.addListener(_onScroll);
    fetchLaboratories(); // جلب الصفحة الأولى تلقائيًا عند التهيئة
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
      (failure) => emit(LaboratoryErrorState(
          failure.errMessage)), // استخدام message بدلاً من errMessage
      (pagination) {
        final laboratories = pagination.laboratories;
        if (isLoadMore) {
          final currentLaboratories =
              (state as LaboratorySuccessState).laboratories;
          emit(LaboratorySuccessState(
              [...currentLaboratories, ...laboratories]));
        } else {
          emit(LaboratorySuccessState(laboratories));
        }
        hasMore =
            laboratories.length == 6; // افتراض أن per_page = 6 هو الحد الأقصى
        if (hasMore) currentPage++;
      },
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchLaboratories(isLoadMore: true);
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose(); // تحرير الموارد
    return super.close();
  }
}
