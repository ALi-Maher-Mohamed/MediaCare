import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';

import '../models/department_model.dart';
import 'department_repo.dart';

class DepartmentRepoImpl implements DepartmentRepo {
  final ApiServiceFunctions apiService;

  DepartmentRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DepartmentModel>> fetchDepartments({page}) async {
    try {
      var data = await apiService
          .get(endpoint: '/api/Departments', queryParams: {"page": page});
      return Right(DepartmentModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
