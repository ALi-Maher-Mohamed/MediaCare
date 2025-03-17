import 'package:dartz/dartz.dart';
import 'package:media_care/presentation/views/Reservation/data/models/reservaion_model.dart';
import '../../../../../../core/errors/failure.dart';

abstract class ReservaionRepo {
  Future<Either<Failure, ReservationModel>> reserve_appointment({
    required String user_id,
    required String doctor_id,
    required String clinic_id,
    required String appointment_id,
    required String status,
    required String token,
  });
}
