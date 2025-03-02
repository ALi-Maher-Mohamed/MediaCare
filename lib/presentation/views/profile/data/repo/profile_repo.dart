import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/profile/data/models/profile_model.dart';


abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getAccount(
      {required String token});
}