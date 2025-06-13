import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/pharmacy_details/cubit/pharmacy_details_state.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/repos/pharmacy_repo.dart';

class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  final PharmacyDetailsRepo repository;

  PharmacyDetailsCubit(this.repository) : super(PharmacyDetailsInitial());

  Future<void> fetchPharmacyDetails(String pharmacyId) async {
    emit(PharmacyDetailsLoading());

    final result = await repository.getPharmacyDetails(pharmacyId);

    result.fold(
      (failure) {
        emit(PharmacyDetailsError(failure.errMessage));
      },
      (pharmacy) {
        emit(PharmacyDetailsSuccess(pharmacy.data));
      },
    );
  }
}
