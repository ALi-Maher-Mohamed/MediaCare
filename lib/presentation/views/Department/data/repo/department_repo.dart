import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import '../models/department_model.dart';

abstract class DepartmentRepo {
  Future<Either<Failure, DepartmentResponse>> getDepartments();
}
