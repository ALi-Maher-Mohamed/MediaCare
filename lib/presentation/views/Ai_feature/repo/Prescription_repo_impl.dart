import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/Ai_feature/data/models/Prescription_details_model.dart';
import 'package:media_care/presentation/views/Ai_feature/repo/Prescription_repo.dart';

class AnalysisRepositoryImpl implements AnalysisRepository {
  final Dio _dio;

  AnalysisRepositoryImpl(this._dio);

  final String baseUrl = 'http://192.168.1.4:8000/api/analyze';

  @override
  Future<Either<String, AnalysisData>> uploadImage(
      String type, FormData formData) async {
    try {
      final response = await _dio.post(
        '$baseUrl/$type',
        data: formData,
      );

      if (response.statusCode == 200) {
        return Right(AnalysisData.fromJson(response.data));
      } else {
        return Left('Failed to analyze: ${response.statusMessage}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
