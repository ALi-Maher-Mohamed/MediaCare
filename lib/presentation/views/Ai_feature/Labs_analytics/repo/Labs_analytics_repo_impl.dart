import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/data/model/Labs_analytics_model.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo.dart';

class LabAnalysisRepositoryImpl implements LabAnalysisRepository {
  final ApiServiceFunctions _apiService;

  LabAnalysisRepositoryImpl(Dio dio) : _apiService = ApiServiceFunctions(dio);

  @override
  Future<Either<String, LabAnalysisData>> analyzeLabTest(
      String type, FormData formData) async {
    try {
      final response = await _apiService.post(
        endpoint: '/api/lab-test-analyzer',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      );
      return Right(LabAnalysisData.fromJson(response));
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
