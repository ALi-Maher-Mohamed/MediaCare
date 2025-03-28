import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/data/models/Prescription_details_model.dart';

abstract class PrescriptionRepo {
  Future<Either<String, PrescriptionData>> uploadImage(
      String type, FormData formData);
}
