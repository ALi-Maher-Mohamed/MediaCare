import 'package:dio/dio.dart';
import '../model/pharmacy_model.dart';

class PharmacyService {
  Dio dio = Dio();

  final String _baseUrl = 'http://192.168.1.4:8000/api/Pharmacies/';

  Future<List<PharmacyModel>> fetchPharmacies() async {
    try {
      final response = await dio.get(_baseUrl);
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
