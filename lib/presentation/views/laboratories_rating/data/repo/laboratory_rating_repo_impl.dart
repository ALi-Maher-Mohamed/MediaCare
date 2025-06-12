import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/laboratories_rating/data/models/laboratory_rating_model.dart';
import 'package:media_care/presentation/views/laboratories_rating/data/repo/laboratory_rating_repo.dart';

class LaboratoryRatingRepoImpl implements LaboratoryRatingRepo {
  final ApiServiceFunctions apiService;

  LaboratoryRatingRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LaboratoryRatingModel>> submitRating({
    required String review,
    required int ratingValue,
    required String userId,
    required String laboratoryId,
    required String? token,
  }) async {
    try {
      if (token == null || token.isEmpty) {
        return left(ServerFailure('Missing authentication token'));
      }

      final response = await apiService.post(
        endpoint: '/api/User_Laboratory',
        data: {
          'review': review,
          'rating_value': ratingValue,
          'user_id': userId,
          'laboratory_id': laboratoryId,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      try {
        final parsedModel = LaboratoryRatingModel.fromJson(response);
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
