import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/repos/medicine_detail_repo.dart';

class MedicineDetailRepositoryImpl implements MedicineDetailRepository {
  final Dio _dio;

  MedicineDetailRepositoryImpl(this._dio);

  final String baseUrl = 'http://192.168.1.4:8000/api/medicine-details';

  @override
  Future<Either<String, MedicineDetail>> getMedicineDetails(
      String medicineName) async {
    try {
      print('Sending request to: $baseUrl/$medicineName');
      final response = await _dio.get(
        '$baseUrl/$medicineName',
        options: Options(
          validateStatus: (status) {
            print('Status code: $status');
            return true;
          },
        ),
      );

      print('Response data: ${response.data}');
      print('Status code: ${response.statusCode}');
      print('Status message: ${response.statusMessage}');

      if (response.statusCode == 200) {
        return Right(MedicineDetail.fromJson(response.data));
      } else {
        return Left(
            'Server error: ${response.statusMessage ?? 'Unknown error'} - Data: ${response.data}');
      }
    } catch (e) {
      print('Error caught: $e');
      if (e is DioException) {
        print('Dio Error details: ${e.response?.data}');
      }
      return Left('Error: $e');
    }
  }
}
