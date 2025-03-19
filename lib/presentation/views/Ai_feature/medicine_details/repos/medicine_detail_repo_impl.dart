import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo.dart';

class MedicineDetailRepositoryImpl implements MedicineDetailRepository {
  final ApiServiceFunctions _apiService;

  MedicineDetailRepositoryImpl(Dio dio)
      : _apiService = ApiServiceFunctions(dio);
  @override
  Future<Either<String, MedicineDetail>> getMedicineDetails(
      String medicineName) async {
    try {
      final response = await _apiService.get(
        endpoint: '/api/medicine-details/$medicineName',
      );
      return Right(MedicineDetail.fromJson(response));
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
