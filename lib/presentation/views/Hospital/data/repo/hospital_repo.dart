import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Hospital/data/models/hospital_model.dart';

abstract class HospitalRepo {
  Future<Either<Failure, HospitalModel>> getHospitals();
}