import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Auth/login/data/models/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> loginUser(
      {required String email, required String password});
}
