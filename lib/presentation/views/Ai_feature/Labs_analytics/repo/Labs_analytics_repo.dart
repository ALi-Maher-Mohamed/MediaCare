import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/data/model/Labs_analytics_model.dart';

abstract class LabAnalysisRepository {
  Future<Either<String, LabAnalysisData>> analyzeLabTest(
      String type, FormData formData);
}
