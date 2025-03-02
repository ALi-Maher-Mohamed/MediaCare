import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Laboratories/data/services/laps_service.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_state.dart';

class LaboratoryCubit extends Cubit<LaboratoryState> {
  final LaboratoryService _laboratoryService;

  LaboratoryCubit(this._laboratoryService) : super(LaboratoryInitialState());

  Future<void> fetchLaboratories() async {
    emit(LaboratoryLoadingState());
    try {
      final laboratories = await _laboratoryService.getLaboratories();
      emit(LaboratorySuccessState(laboratories));
    } catch (e) {
      emit(LaboratoryFailure(e.toString()));
    }
  }
}
