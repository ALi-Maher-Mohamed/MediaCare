import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Auth/login/data/models/login_model.dart';
import 'package:media_care/presentation/views/Auth/login/data/repo/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiServiceFunctions apiService;
  LoginRepoImpl(this.apiService);
  @override
  Future<Either<Failure, LoginModel>> loginUser(
      {required email, required password}) async {
    try {
      var data = await apiService.post(endpoint: '/api/user/login', data: {
        'email': email.trim(), // Ensure no extra spaces
        'password': password,
      });
      return Right(LoginModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
