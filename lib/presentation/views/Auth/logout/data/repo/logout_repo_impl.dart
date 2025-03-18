import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Auth/logout/data/models/logout_model.dart';
import 'package:media_care/presentation/views/Auth/logout/data/repo/logout_repo.dart';

class LogoutRepoImpl implements LogoutRepo {
  final ApiServiceFunctions apiService;

  LogoutRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LogoutModel>> logout({
    required String? token,
  }) async {
    try {
      if (token == null || token.isEmpty) {
        return left(
            ServerFailure("Authentication error: Missing or invalid token."));
      }
      var data = await apiService.post(
        endpoint: '/api/user/logout',
        data: {},
        headers: {
          'Authorization': 'Bearer ${token.trim()}',
        },
      );

      return Right(LogoutModel.fromJson(data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
