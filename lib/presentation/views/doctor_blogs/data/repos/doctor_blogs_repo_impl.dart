import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';

class BlogsRepoImpl implements BlogsRepo {
  final ApiServiceFunctions apiService;

  BlogsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, BlogResponse>> fetchBlogs() async {
    try {
      final response = await apiService.get(endpoint: '/api/Blogs_Web');
      final blog = BlogResponse.fromJson(response);
      return Right(blog);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected Error: $e'));
    }
  }
}
