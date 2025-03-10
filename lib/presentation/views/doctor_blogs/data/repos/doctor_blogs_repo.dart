import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';

abstract class BlogsRepo {
  Future<BlogResponse> fetchBlogs();
}
