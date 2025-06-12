import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Doctor_rating/data/model/doctor_rating_model.dart';

abstract class DoctorRatingRepo {
  Future<Either<Failure, DoctorRatingModel>> submitRating({
    required String review,
    required int ratingValue,
    required String userId,
    required String doctorId,
    required String? token,
  });
}
