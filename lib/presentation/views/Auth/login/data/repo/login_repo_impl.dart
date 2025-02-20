import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/api_service.dart';
import '../models/login_model.dart';
import 'login_repo.dart';

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
