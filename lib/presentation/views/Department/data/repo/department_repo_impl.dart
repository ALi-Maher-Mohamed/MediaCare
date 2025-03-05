import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_service.dart';

import '../models/department_model.dart';
import 'department_repo.dart';

class DepartmentRepoImpl implements DepartmentRepo {
  final ApiServiceFunctions apiService;

  DepartmentRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DepartmentResponse>> getDepartments() async {
    try {
      final response = await apiService.get(endpoint: '/api/Departments');
      final departmentResponse = DepartmentResponse.fromJson(response);
      return Right(departmentResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
