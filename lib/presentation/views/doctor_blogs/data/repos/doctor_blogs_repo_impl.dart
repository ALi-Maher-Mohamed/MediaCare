import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart'; // تأكد من تعديل المسار حسب مكان Failure
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';

class BlogsRepoImpl implements BlogsRepo {
  final Dio _dio;

  BlogsRepoImpl(this._dio);

  @override
  Future<Either<Failure, BlogResponse>> fetchBlogs() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/api/Blogs_Web');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          final blog = BlogResponse.fromJson(data);
          return Right(blog);
        } else {
          return Left(ServerFailure(
              'Unexpected data format: Expected a single blog object'));
        }
      } else {
        return Left(
            ServerFailure.fromResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected Error: $e'));
    }
  }
}
