import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../models/department_model.dart';

abstract class DepartmentRepo {
  Future<Either<Failure, DepartmentResponse>> getDepartments();
}
