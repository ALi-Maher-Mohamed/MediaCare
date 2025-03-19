import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/manager/cubit/prescription_state.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/repo/Prescription_repo.dart';

class PrescriptionCubit extends Cubit<AnalysisState> {
  final PrescriptionRepo _repository;

  PrescriptionCubit(this._repository) : super(AnalysisInitial());

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
