import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/laboratory_details/data/models/laboratory_details_model.dart';

abstract class LaboratoryRepository {
  Future<Either<Failure, LaboratoryDetailsResponse>> getLaboratory(String id);
}
