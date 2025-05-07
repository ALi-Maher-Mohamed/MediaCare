import 'package:dartz/dartz.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/appointments_model.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/cancel_model.dart';
import 'package:media_care/presentation/views/My%20appointments/data/models/confirm_model.dart';
import '../../../../../core/errors/failure.dart';

abstract class MyAppointmentsRepo {
  Future<Either<Failure, myAppointmentsModel>> getAppointment(
      {required String token});

  Future<Either<Failure, ConfirmModel>> confirmAppointment(
      {required String token, required String id});

  Future<Either<Failure, CancelModel>> cancelAppointment(
      {required String token, required String id});
}
