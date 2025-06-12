import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/model/pharmacy_rating_model.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/repos/pharmacy_rating_repo.dart';

class PharmacyRatingRepoImpl implements PharmacyRatingRepo {
  final ApiServiceFunctions apiService;

  PharmacyRatingRepoImpl(this.apiService);

  @override
  Future<Either<Failure, PharmacyRatingModel>> submitRating({
    required String review,
    required int ratingValue,
    required String userId,
    required String pharmacyId,
    required String? token,
  }) async {
    try {
      if (token == null || token.isEmpty) {
        return left(ServerFailure('Missing authentication token'));
      }

      final response = await apiService.post(
        endpoint: '/api/User_Pharmacy',
        data: {
          'review': review,
          'rating_value': ratingValue,
          'user_id': userId,
          'pharmacy_id': pharmacyId,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      try {
        final parsedModel = PharmacyRatingModel.fromJson(response);
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
