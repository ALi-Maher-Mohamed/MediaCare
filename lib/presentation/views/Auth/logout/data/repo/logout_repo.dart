import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Auth/logout/data/models/logout_model.dart';

abstract class LogoutRepo {
  Future<Either<Failure, LogoutModel>> logout({
    required String token,
  });
}
