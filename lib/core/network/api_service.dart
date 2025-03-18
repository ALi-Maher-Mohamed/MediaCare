import 'package:dio/dio.dart';

class ApiServiceFunctions {
  final Dio dio;
  final String baseUrl = 'http://10.0.2.2:8000';
  ApiServiceFunctions(this.dio);
  //Ali Maher BaseUrl --> http://192.168.1.4:8000
  //Ahmed Mansour BaseUrl --> http://10.0.2.2:8000
  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    var response = await dio.post(
      '$baseUrl$endpoint',
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl$endpoint',
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }
}
