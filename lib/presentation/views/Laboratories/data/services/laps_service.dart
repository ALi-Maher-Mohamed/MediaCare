import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/data.dart';

class LaboratoryService {
  Future<List<LaboratoryModel>> getLaboratories() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.4:8000/api/Laboratories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> labsData = data['data']['data']; // الوصول إلى قائمة المعامل
      return labsData.map((json) => LaboratoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load laboratories');
    }
  }
}
