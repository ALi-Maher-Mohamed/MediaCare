import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/model/pharmacy_rating_model.dart';

abstract class PharmacyRatingRepo {
  Future<Either<Failure, PharmacyRatingModel>> submitRating({
    required String review,
    required int ratingValue,
    required String userId,
    required String pharmacyId,
    required String? token,
  });
}
