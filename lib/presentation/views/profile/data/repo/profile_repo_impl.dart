import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../models/profile_model.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiServiceFunctions apiService;
  ProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, UserModel>> getAccount(
      {required String? token}) async {
    try {
      var user = await apiService.get(
        endpoint: '/api/user/getaccount',
        headers: {
          'Authorization': 'Bearer $token'
        }, // Pass the token in headers
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
