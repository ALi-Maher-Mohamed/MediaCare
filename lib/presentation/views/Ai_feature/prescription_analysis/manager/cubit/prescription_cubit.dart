import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_state.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionRepo _repository;

  PrescriptionCubit(this._repository) : super(PrescriptionInitial());

  Future<void> analyzeImage(String type, FormData formData) async {
    emit(PrescriptionLoading());

    final result = await _repository.uploadImage(type, formData);
    result.fold(
      (failure) {
        emit(PrescriptionFailure(failure));
      },
      (success) {
        emit(PrescriptionSuccess(success));
      },
    );
  }
}
