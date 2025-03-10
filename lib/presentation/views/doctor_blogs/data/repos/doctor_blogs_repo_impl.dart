// data/repos/blogs_repo_impl.dart
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';

class BlogsRepoImpl implements BlogsRepo {
  final Dio _dio = Dio();

  @override
  Future<BlogResponse> fetchBlogs() async {
    try {
      final response = await _dio.get('http://192.168.1.4:8000/api/Blogs_Web');
      if (response.statusCode == 200) {
        return BlogResponse.fromJson(response.data);
      } else {
        throw Exception('فشل في جلب البيانات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }
}
