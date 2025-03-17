import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/Reservation/data/models/reservaion_model.dart';
import 'package:media_care/presentation/views/Reservation/data/repo/reservation_repo.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/api_service.dart';

class ReservaionRepoImpl implements ReservaionRepo {
  final ApiServiceFunctions apiService;

  ReservaionRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ReservationModel>> reserve_appointment({
    required String user_id,
    required String doctor_id,
    required String clinic_id,
    required String appointment_id,
    required String status,
    required String? token,
  }) async {
    try {
      if (token == null || token.isEmpty) {
        return left(ServerFailure("Authentication error: Missing token."));
      }
      var data = await apiService.post(
        endpoint: '/api/reservations',
        data: {
          "user_id": user_id,
          "doctor_id": doctor_id,
          "clinic_id": clinic_id,
          "appointment_id": appointment_id,
          "status": status,
        },
        headers: {
          'Authorization': 'Bearer ${token.trim()}',
        },
      );
      return Right(ReservationModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
