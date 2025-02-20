import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../models/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> loginUser(
      {required String email, required String password});
}
