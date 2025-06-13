import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/laboratory_details/cubit/laboratory_details_state.dart';
import 'package:media_care/presentation/views/laboratory_details/data/repos/laboratory_details_repo.dart';

class LaboratoryCubit extends Cubit<LaboratoryState> {
  final LaboratoryRepository repository;

  LaboratoryCubit(this.repository) : super(LaboratoryInitial());

  Future<void> fetchLaboratory(String id) async {
    emit(LaboratoryLoading());

    final result = await repository.getLaboratory(id);

    result.fold(
      (failure) => emit(LaboratoryError(failure.errMessage)),
      (response) => emit(LaboratoryLoaded(response)),
    );
  }
}
