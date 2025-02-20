import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/service/api_service.dart';
import '../../data/model/pharmacy_model.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyService apiService;

  PharmacyCubit({required this.apiService}) : super(PharmacyInitial());

  Future<void> loadPharmacies() async {
    emit(PharmacyLoading());
    try {
      final pharmacies = await apiService.fetchPharmacies();
      emit(PharmacySuccessState(pharmacies));
    } catch (e) {
      emit(PharmacyError(e.toString()));
      print(e.toString());
    }
  }
}
