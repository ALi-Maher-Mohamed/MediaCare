import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';

class LabAnalysisCubit extends Cubit<AiState> {
  final LabAnalysisRepository _repository;

  LabAnalysisCubit(this._repository) : super(AiInitial());

  Future<void> analyzeLabTest(String type, FormData formData) async {
    emit(AiLoading(AnalysisType.lab));

    final result = await _repository.analyzeLabTest(type, formData);
    result.fold(
      (failure) {
        emit(AiFailure(AnalysisType.lab, failure));
        print(failure);
      },
      (success) {
        emit(AiSuccess(AnalysisType.lab, success));
      },
    );
  }
}
