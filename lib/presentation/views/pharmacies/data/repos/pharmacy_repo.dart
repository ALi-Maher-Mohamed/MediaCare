import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';

abstract class PharmacyRepo {
  PharmacyRepo(pharmacyService);

  Future<List<PharmacyModel>> getPharmacies({int page = 1});
}
