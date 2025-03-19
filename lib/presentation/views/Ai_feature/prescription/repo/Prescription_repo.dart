import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/data/models/Prescription_details_model.dart';

abstract class PrescriptionRepo {
  Future<Either<String, AnalysisData>> uploadImage(
      String type, FormData formData);
}
