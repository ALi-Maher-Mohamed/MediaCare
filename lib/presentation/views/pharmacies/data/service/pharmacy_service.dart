import 'package:dio/dio.dart';
import '../model/pharmacy_pagination.dart';

class PharmacyService {
  final Dio dio = Dio();
  final String baseUrl = "http://10.0.2.2:8000/api/Pharmacies";

  Future<PaginationModel> fetchPharmacies({int page = 1}) async {
    try {
      final response = await dio.get('$baseUrl?page=$page');
      if (response.statusCode == 200) {
        return PaginationModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to load pharmacies");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
