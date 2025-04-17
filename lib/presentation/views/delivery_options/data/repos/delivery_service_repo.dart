import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import '../models/delivery_service_model.dart';

abstract class DeliveryServiceRepo {
  Future<Either<Failure, List<DeliveryServiceModel>>> fetchDeliveryServices();
}
