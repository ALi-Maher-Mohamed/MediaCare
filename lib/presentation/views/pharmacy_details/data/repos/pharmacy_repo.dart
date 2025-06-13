import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/model/pharmacy_details.dart';

abstract class PharmacyDetailsRepo {
  Future<Either<Failure, PharmacyResponse>> getPharmacyDetails(
      String pharmacyId);
}
