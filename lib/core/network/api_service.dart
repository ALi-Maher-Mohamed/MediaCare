import 'package:dio/dio.dart';

class ApiServiceFunctions {
  final Dio dio;

  ApiServiceFunctions(this.dio);

  Future<Map<String, dynamic>> post(
      {required String endpoint, required Map<String, dynamic> data}) async {
    var response = await dio.post('http://10.0.2.2:8000$endpoint',
        data: data, options: Options(headers: {}));
    return response.data;
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        'http://10.0.2.2:8000$endpoint', // Replace with your base URL
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }
}
