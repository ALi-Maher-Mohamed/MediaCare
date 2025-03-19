import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/data/model/Labs_analytics_model.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo.dart';

class LabAnalysisRepositoryImpl implements LabAnalysisRepository {
  final Dio _dio;

  LabAnalysisRepositoryImpl(this._dio);

  final String baseUrl = 'http://192.168.1.4:8000/api/lab-test-analyzer';

  @override
  Future<Either<String, LabAnalysisData>> analyzeLabTest(
      String type, FormData formData) async {
    try {
      print('Sending request to: $baseUrl with type: $type');
      print('FormData fields: ${formData.fields}');
      print('FormData files: ${formData.files}');

      final response = await _dio.post(
        baseUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
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
        return Right(LabAnalysisData.fromJson(response.data));
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
