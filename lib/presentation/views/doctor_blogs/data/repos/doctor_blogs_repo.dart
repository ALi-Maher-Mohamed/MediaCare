import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart'; // تأكد من تعديل المسار حسب مكان Failure
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';

abstract class BlogsRepo {
  Future<Either<Failure, BlogResponse>> fetchBlogs();
}
