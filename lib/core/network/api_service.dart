import 'package:dio/dio.dart';

class ApiServiceFunctions {
  final Dio dio;
  final String baseUrl = 'http://192.168.1.4:8000';

  //Ali Maher BaseUrl --> http://192.168.1.4:8000
  //Ahmed Mansour BaseUrl --> http://10.0.2.2:8000
  // https://b4d7-197-38-194-214.ngrok-free.app

  ApiServiceFunctions(this.dio);

  Future<dynamic> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl$endpoint',
        data: data,
        options: Options(headers: headers, validateStatus: (status) => true),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Server error: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.get(
        '$baseUrl$endpoint',
        queryParameters: queryParams,
        options: Options(headers: headers, validateStatus: (status) => true),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Server error: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<dynamic> put({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.put(
        '$baseUrl$endpoint',
        data: data,
        options: Options(headers: headers, validateStatus: (status) => true),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Server error: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw e;
    }
  }
}
