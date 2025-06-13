import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/laboratory_details/cubit/laboratory_details_state.dart';
import 'package:media_care/presentation/views/laboratory_details/data/repos/laboratory_details_repo.dart';

class LaboratoryDetailsCubit extends Cubit<LaboratoryDetailsState> {
  final LaboratoryRepository repository;

  LaboratoryDetailsCubit(this.repository) : super(LaboratoryDetailsInitial());

  Future<void> fetchLaboratory(String id) async {
    emit(LaboratoryDetailsLoading());

    final result = await repository.getLaboratory(id);

    result.fold(
      (failure) => emit(LaboratoryDetailsError(failure.errMessage)),
      (response) => emit(LaboratoryDetailsSuccess(response)),
    );
  }
}
