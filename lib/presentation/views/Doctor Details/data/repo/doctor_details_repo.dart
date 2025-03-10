import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';

abstract class DoctorDetailsRepo {
  Future<Either<Failure, DoctorDetailsModel>> getDoctorDetails(String? id);
}
