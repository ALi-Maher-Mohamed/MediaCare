import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Laboratories/data/services/laps_service.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_state.dart';

class LaboratoryCubit extends Cubit<LaboratoryState> {
  final LaboratoryService _laboratoryService;

  LaboratoryCubit(this._laboratoryService) : super(LaboratoryInitial());

  Future<void> fetchLaboratories() async {
    emit(LaboratoryLoading());
    try {
      final laboratories = await _laboratoryService.getLaboratories();
      emit(LaboratoryLoaded(laboratories));
    } catch (e) {
      emit(LaboratoryError(e.toString()));
    }
  }
}
