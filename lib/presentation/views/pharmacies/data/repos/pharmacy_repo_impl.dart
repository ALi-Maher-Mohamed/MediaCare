import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'pharmacy_repo.dart';

class PharmacyRepoImpl implements PharmacyRepo {
  final Dio _dio;

  PharmacyRepoImpl(this._dio);

  @override
  Future<List<PharmacyModel>> getPharmacies({int page = 1}) async {
    try {
      final response = await _dio.get(
        'http://192.168.1.4:8000/api/Pharmacies',
        queryParameters: {'page': page},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data']['data'];
          return data.map((json) => PharmacyModel.fromJson(json)).toList();
        } else {
          throw Exception(
              jsonResponse['message'] ?? 'Failed to load pharmacies');
        }
      } else {
        throw Exception('Failed to load pharmacies');
      }
    } catch (e) {
      throw Exception('Error fetching pharmacies: $e');
    }
  }
}
