import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/laboratories_rating/data/models/laboratory_rating_model.dart';

abstract class LaboratoryRatingRepo {
  Future<Either<Failure, LaboratoryRatingModel>> submitRating({
    required String review,
    required int ratingValue,
    required String userId,
    required String laboratoryId,
    required String? token,
  });
}
