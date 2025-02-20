import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:8000/api/Pharmacies';

  Future<List<PharmacyModel>> fetchPharmacies() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        final List data = response.data['data']['data'];
        return data.map((json) => PharmacyModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pharmacies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


class ApiServiceFunctions {
  final Dio dio;
  ApiServiceFunctions(this.dio);
  Future<Map<String, dynamic>> post(
      {required String endpoint, required Map<String, dynamic> data}) async {
    var response = await dio.post('http://10.0.2.2:8000$endpoint',
        data: data, options: Options(headers: {}));
    return response.data;
  }
}

