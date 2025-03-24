import 'package:dio/dio.dart';

class ApiServiceFunctions {
  final Dio dio;
  final String baseUrl = 'http://192.168.1.4:8000';
  //Ali Maher BaseUrl --> http://192.168.1.4:8000
  //Ahmed Mansour BaseUrl --> http://10.0.2.2:8000
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
}

// class ApiServiceFunctions {
//   final Dio dio;
//   final String baseUrl = 'http://192.168.1.4:8000';
//   ApiServiceFunctions(this.dio);
//   Future<Map<String, dynamic>> post({
//     required String endpoint,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? headers,
//   }) async {
//     var response = await dio.post(
//       '$baseUrl$endpoint',
//       data: data,
//       options: Options(headers: headers),
//     );
//     return response.data;
//   }

//   Future<Map<String, dynamic>> get({
//     required String endpoint,
//     Map<String, dynamic>? queryParams,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       final response = await dio.get(
//         '$baseUrl$endpoint',
//         queryParameters: queryParams,
//         options: Options(headers: headers),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       throw e;
//     }
//   }
// }
