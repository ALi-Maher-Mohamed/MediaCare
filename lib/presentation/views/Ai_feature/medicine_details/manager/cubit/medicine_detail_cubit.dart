import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo.dart';

import 'medicine_detail_state.dart';

class MedicineDetailCubit extends Cubit<MedicineDetailState> {
  final MedicineDetailRepository _repository;

  MedicineDetailCubit(this._repository) : super(MedicineDetailInitial());

  Future<void> fetchMedicineDetails(String medicineName) async {
    print('Fetching details for: $medicineName');
    emit(MedicineDetailLoading());

    final result = await _repository.getMedicineDetails(medicineName);
    result.fold(
      (failure) {
        print('Failure: $failure');
        emit(MedicineDetailFailure(failure));
      },
      (success) {
        print('Success: $success');
        emit(MedicineDetailSuccess(success));
      },
    );
  }
}
