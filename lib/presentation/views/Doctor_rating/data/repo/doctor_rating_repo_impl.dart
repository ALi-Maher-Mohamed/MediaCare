import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Doctor_rating/data/model/doctor_rating_model.dart';
import 'package:media_care/presentation/views/Doctor_rating/data/repo/doctor_rating_repo.dart';

class DoctorRatingRepoImpl implements DoctorRatingRepo {
  final ApiServiceFunctions apiService;

  DoctorRatingRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DoctorRatingModel>> submitRating({
    required String review,
    required int ratingValue,
    required String userId,
    required String doctorId,
    required String? token,
  }) async {
    try {
      if (token == null || token.isEmpty) {
        return left(ServerFailure('Missing authentication token'));
      }

      final response = await apiService.post(
        endpoint: '/api/User_Doctor', // Update with your actual endpoint
        data: {
          'review': review,
          'rating_value': ratingValue,
          'user_id': userId,
          'doctor_id': doctorId,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      try {
        final parsedModel = DoctorRatingModel.fromJson(response);
        return Right(parsedModel);
      } catch (e) {
        return left(ServerFailure('Failed to parse server response'));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure('Unexpected Error: ${e.toString()}'));
    }
  }
}
