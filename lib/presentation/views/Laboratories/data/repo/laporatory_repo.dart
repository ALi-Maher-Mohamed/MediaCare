import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import '../model/labs_model/pagination_labs_model.dart';

abstract class LaboratoryRepo {
  Future<Either<Failure, LaboratoryPagination>> getLaboratories({int page = 1});
}
