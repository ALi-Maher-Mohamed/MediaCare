import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/hospital_repo_impl.dart';
import 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalRepoImpl hospitalRepo;

  HospitalCubit({required this.hospitalRepo}) : super(HospitalInitial());

  Future<void> fetchHospitals() async {
    emit(HospitalLoading());
    try {
      final result = await hospitalRepo.getHospitals();
      result.fold(
            (failure) => emit(HospitalError(failure.errMessage)),
            (hospitalResponse) => emit(HospitalLoaded(hospitalResponse)),
      );
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }
}