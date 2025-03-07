import 'package:dio/dio.dart';
import '../model/labs_model/pagination_labs_model.dart';

class LaboratoryService {
  final Dio _dio = Dio();
  final String baseUrl = "http://127.0.0.1:8000/api/Laboratories";

  Future<LaboratoryPagination> fetchLaboratories(int page) async {
    final response = await _dio.get("$baseUrl?page=$page");
    return LaboratoryPagination.fromJson(response.data['data']);
  }
}
