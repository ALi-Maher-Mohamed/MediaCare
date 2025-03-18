import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/Ai_feature/data/models/Prescription_details_model.dart';

abstract class AnalysisRepository {
  Future<Either<String, AnalysisData>> uploadImage(
      String type, FormData formData);
}
