import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/api_service.dart';
import '../models/register_model.dart';
import 'register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final ApiServiceFunctions apiService;

  RegisterRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RegisterModel>> registerUser(
      {required name,
      required email,
      required phone,
      required address,
      required birth_date,
      required password,
      required password_confirmation}) async {
    try {
      var data = await apiService.post(endpoint: '/api/user/register', data: {
        "name": name,
        "email": email.trim(),
        "phone": phone,
        "address": address,
        "birth_date": birth_date,
        "password": password,
        "password_confirmation": password_confirmation,
      });
      return Right(RegisterModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        if (e is DioException) {
          if (e.response?.statusCode == 400) {
            final errorResponse = e.response?.data;
            if (errorResponse != null &&
                errorResponse is Map<String, dynamic>) {
              if (errorResponse.containsKey("email")) {
                return left(ServerFailure(errorResponse["email"][0]));
              }
            }
          }
          return left(ServerFailure.fromDioError(e));
        }
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
