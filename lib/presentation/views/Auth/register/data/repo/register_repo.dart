import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/Auth/register/data/models/register_model.dart';


abstract class RegisterRepo {
  Future<Either<Failure, RegisterModel>> registerUser(
      {required String name,
        required String email,
        required String phone,
        required String address,
        required String birth_date,
        required String password,
        required String password_confirmation});
}
