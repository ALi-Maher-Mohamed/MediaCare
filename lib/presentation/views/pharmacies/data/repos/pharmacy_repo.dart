import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';

abstract class PharmacyRepo {
  Future<Either<Failure, List<PharmacyModel>>> getPharmacies({int page = 1});
}
