import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/laboratory_details/data/models/laboratory_details_model.dart';
import 'package:media_care/presentation/views/laboratory_details/data/repos/laboratory_details_repo.dart';

class LaboratoryRepositoryImpl implements LaboratoryRepository {
  final ApiServiceFunctions apiService;

  LaboratoryRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, LaboratoryDetailsResponse>> getLaboratory(
      String id) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/Laboratories/$id',
      );

      if (response['success'] == true) {
        return Right(LaboratoryDetailsResponse.fromJson(response));
      } else {
        return Left(ServerFailure(response['message'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
