import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo.dart';

class SymptomAnalysisCubit extends Cubit<AiState> {
  final SymptomAnalysisRepository _repository;

  SymptomAnalysisCubit(this._repository) : super(AiInitial());

  Future<void> analyzeSymptoms(String type, dynamic data) async {
    print('Analyzing symptoms with type: $type');
    emit(AiLoading(AnalysisType.symptom));

    final result = await _repository.analyzeSymptoms(type, data);
    print('Result from Repository: $result');
    result.fold(
      (failure) {
        print('Failure: $failure');
        emit(AiFailure(AnalysisType.symptom, failure));
      },
      (success) {
        print('Success: $success');
        emit(AiSuccess(AnalysisType.symptom, success));
      },
    );
  }
}
