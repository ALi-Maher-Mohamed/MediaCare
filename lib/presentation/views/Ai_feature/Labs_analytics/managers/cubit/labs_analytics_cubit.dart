import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_state.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo.dart';

class LabAnalysisCubit extends Cubit<LabAnalysisState> {
  final LabAnalysisRepository _repository;

  LabAnalysisCubit(this._repository) : super(LabAnalysisInitial());

  Future<void> analyzeLabTest(String type, FormData formData) async {
    emit(LabAnalysisLoading());

    final result = await _repository.analyzeLabTest(type, formData);
    result.fold(
      (failure) {
        emit(LabAnalysisFailure(failure));
        print(failure);
      },
      (success) {
        emit(LabAnalysisSuccess(success));
      },
    );
  }
}
