import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/profile/data/models/profile_model.dart';
import 'package:media_care/presentation/views/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiServiceFunctions apiService;
  ProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, UserModel>> getAccount({required String? token}) async {
    try {
      var user = await apiService.get(
        endpoint: '/api/user/getaccount',
        headers: {'Authorization': 'Bearer $token'}, // Pass the token in headers
      );
      return Right(UserModel.fromJson(user));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}