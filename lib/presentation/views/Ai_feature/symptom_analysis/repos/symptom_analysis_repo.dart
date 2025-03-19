import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/data/models/symptoms_model.dart';

abstract class SymptomAnalysisRepository {
  Future<Either<String, SymptomAnalysisData>> analyzeSymptoms(
      String type, FormData formData);
}
