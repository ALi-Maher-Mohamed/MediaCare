import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';

abstract class DepartmentDetailsRepo {
  Future<Either<Failure, DepartmentDetailsModel>> getDepartmentDetails(
      String? id);
}
