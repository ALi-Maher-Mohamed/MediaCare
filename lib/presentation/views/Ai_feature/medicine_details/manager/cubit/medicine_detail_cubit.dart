import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/AI_Feature/cubit/ai_state.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo.dart';

class MedicineDetailCubit extends Cubit<AiState> {
  final MedicineDetailRepository _repository;

  MedicineDetailCubit(this._repository) : super(AiInitial());

  Future<void> fetchMedicineDetails(String medicineName) async {
    print('Fetching details for: $medicineName');
    emit(AiLoading(AnalysisType.medicine));

    final result = await _repository.getMedicineDetails(medicineName);
    result.fold(
      (failure) {
        print('Failure: $failure');
        emit(AiFailure(AnalysisType.medicine, failure));
      },
      (success) {
        print('Success: $success');
        emit(AiSuccess(AnalysisType.medicine, success));
      },
    );
  }
}
