import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/data/models/symptoms_model.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo.dart';

class SymptomAnalysisRepositoryImpl implements SymptomAnalysisRepository {
  final Dio _dio;

  SymptomAnalysisRepositoryImpl(this._dio);

  final String baseUrl = 'http://192.168.1.4:8000/api/ai-analysis';

  @override
  Future<Either<String, SymptomAnalysisData>> analyzeSymptoms(
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
        return Right(SymptomAnalysisData.fromJson(response.data));
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
