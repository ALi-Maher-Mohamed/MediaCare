import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/appointments_model.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/cancel_model.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/confirm_model.dart';
import 'package:media_care/presentation/views/My%20appointments/data/repo/appointments_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_service.dart';

class MyAppointmentsRepoImpl implements MyAppointmentsRepo {
  final ApiServiceFunctions apiService;

  MyAppointmentsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, myAppointmentsModel>> getAppointment(
      {required String? token}) async {
    try {
      var user = await apiService.get(
        endpoint: '/api/user/reservations',
        headers: {
          'Authorization': 'Bearer $token'
        }, // Pass the token in headers
      );
      return Right(myAppointmentsModel.fromJson(user));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CancelModel>> cancelAppointment({
    required String token,
    required String id,
  }) async {
    try {
      if (token.isEmpty) {
        return left(ServerFailure("Authentication error: Missing token."));
      }
      var data = await apiService.put(
        endpoint: '/api/reservations/${id.trim()}/cancel',
        data: {},
        headers: {
          'Authorization': 'Bearer ${token.trim()}',
        },
      );
      return Right(CancelModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmModel>> confirmAppointment(
      {required String token, required String id}) async {
    try {
      if (token.isEmpty) {
        return left(ServerFailure("Authentication error: Missing token."));
      }
      var data = await apiService.put(
        endpoint: '/api/reservations/${id.trim()}/confirm',
        data: {},
        headers: {
          'Authorization': 'Bearer ${token.trim()}',
        },
      );
      return Right(ConfirmModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
