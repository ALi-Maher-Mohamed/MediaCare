import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Department_Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Department_Details/data/repo/department_details_repo.dart';

class DepartmentDetailsRepoImpl implements DepartmentDetailsRepo {
  final ApiServiceFunctions apiService;
  DepartmentDetailsRepoImpl(this.apiService);
  @override
  Future<Either<Failure, DepartmentDetailsModel>> getDepartmentDetails(
      String? id) async {
    try {
      final response = await apiService.get(endpoint: '/api/Departments/$id');
      final departmentDetailsResponse =
          DepartmentDetailsModel.fromJson(response);
      return Right(departmentDetailsResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
