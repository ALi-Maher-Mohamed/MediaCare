import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/data/models/symptoms_model.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo.dart';

class SymptomAnalysisRepositoryImpl implements SymptomAnalysisRepository {
  final ApiServiceFunctions _apiService;

  SymptomAnalysisRepositoryImpl(Dio dio)
      : _apiService = ApiServiceFunctions(dio);

  @override
  Future<Either<String, SymptomAnalysisData>> analyzeSymptoms(
      String type, dynamic data) async {
    try {
      Map<String, dynamic> response;
      if (data is FormData) {
        response = await _apiService.post(
          endpoint: '/api/ai-analysis',
          data: data,
          headers: {'Content-Type': 'multipart/form-data'},
        );
      } else if (data is Map<String, dynamic>) {
        response = await _apiService.post(
          endpoint: '/api/ai-analysis',
          data: data,
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        return Left('Error: Unsupported data type');
      }
      return Right(SymptomAnalysisData.fromJson(response));
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
