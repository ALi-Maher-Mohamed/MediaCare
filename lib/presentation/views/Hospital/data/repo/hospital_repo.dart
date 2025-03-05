import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../models/hospital_model.dart';

abstract class HospitalRepo {
  Future<Either<Failure, HospitalModel>> getHospitals();
}
