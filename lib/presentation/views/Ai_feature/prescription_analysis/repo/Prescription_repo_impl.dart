import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/data/models/Prescription_details_model.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo.dart';

class PrescriptionRepoImpl implements PrescriptionRepo {
  final ApiServiceFunctions _apiService;

  PrescriptionRepoImpl(Dio dio) : _apiService = ApiServiceFunctions(dio);

  @override
  Future<Either<String, PrescriptionData>> uploadImage(
      String type, FormData formData) async {
    try {
      final response = await _apiService.post(
        endpoint: '/api/analyze/$type',
        data: formData, // الـ FormData هنا بتشتغل مع Dio مباشرة
        headers: {'Content-Type': 'multipart/form-data'},
      );
      return Right(PrescriptionData.fromJson(response));
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
