import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo.dart';

class PrescriptionCubit extends Cubit<AiState> {
  final PrescriptionRepo _repository;

  PrescriptionCubit(this._repository) : super(AiInitial());

  Future<void> analyzeImage(String type, FormData formData) async {
    emit(AiLoading(AnalysisType.prescription));

    final result = await _repository.uploadImage(type, formData);
    result.fold(
      (failure) {
        emit(AiFailure(AnalysisType.prescription, failure));
      },
      (success) {
        emit(AiSuccess(AnalysisType.prescription, success));
      },
    );
  }
}
