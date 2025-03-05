import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getAccount({required String token});
}
