import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/Ai_feature/manager/cubit/prescription_state.dart';
import 'package:media_care/presentation/views/Ai_feature/repo/Prescription_repo.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  final AnalysisRepository _repository;

  AnalysisCubit(this._repository) : super(AnalysisInitial());

  Future<void> analyzeImage(String type, FormData formData) async {
    emit(AnalysisLoading()); // إظهار حالة التحميل

    final result = await _repository.uploadImage(type, formData);
    result.fold(
      (failure) {
        emit(AnalysisFailure(failure));
      },
      (success) {
        emit(AnalysisSuccess(success));
      },
    );
  }
}
