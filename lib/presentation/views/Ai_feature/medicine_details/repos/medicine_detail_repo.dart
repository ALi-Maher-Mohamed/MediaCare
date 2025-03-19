import 'package:dartz/dartz.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';

abstract class MedicineDetailRepository {
  Future<Either<String, MedicineDetail>> getMedicineDetails(
      String medicineName);
}
