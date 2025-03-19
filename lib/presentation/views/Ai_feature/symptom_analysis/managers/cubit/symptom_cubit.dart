import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_state.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo.dart';

class SymptomAnalysisCubit extends Cubit<SymptomAnalysisState> {
  final SymptomAnalysisRepository _repository;

  SymptomAnalysisCubit(this._repository) : super(SymptomAnalysisInitial());

  Future<void> analyzeSymptoms(String type, FormData formData) async {
    print('Analyzing symptoms with type: $type');
    emit(SymptomAnalysisLoading());

    final result = await _repository.analyzeSymptoms(type, formData);
    result.fold(
      (failure) {
        print('Failure: $failure');
        emit(SymptomAnalysisFailure(failure));
      },
      (success) {
        print('Success: $success');
        emit(SymptomAnalysisSuccess(success));
      },
    );
  }
}
