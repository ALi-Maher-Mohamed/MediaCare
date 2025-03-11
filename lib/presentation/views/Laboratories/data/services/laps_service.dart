import 'package:dio/dio.dart';
import '../model/labs_model/pagination_labs_model.dart';

class LaboratoryService {
  final Dio _dio = Dio();
  //Ali Maher BaseUrl --> http://192.168.1.4:8000
  //Ahmed Mansour BaseUrl --> http://10.0.2.2:8000
  final String baseUrl = "http://10.0.2.2:8000/api/Laboratories";

  Future<LaboratoryPagination> fetchLaboratories(int page) async {
    final response = await _dio.get("$baseUrl?page=$page");
    return LaboratoryPagination.fromJson(response.data['data']);
  }
}
