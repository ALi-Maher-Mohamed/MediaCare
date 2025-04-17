import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import '../models/delivery_service_model.dart';
import 'delivery_service_repo.dart';

class DeliveryServiceRepoImpl implements DeliveryServiceRepo {
  final ApiServiceFunctions apiService;

  DeliveryServiceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<DeliveryServiceModel>>>
      fetchDeliveryServices() async {
    try {
      final response = await apiService.get(
        endpoint: '/api/Delivery_Services',
      );

      if (response['success'] == true) {
        final List<dynamic> data = response['data'];
        final services =
            data.map((json) => DeliveryServiceModel.fromJson(json)).toList();
        return Right(services);
      } else {
        return Left(ServerFailure('Failed to load delivery services'));
      }
    } catch (e) {
      return Left(ServerFailure('Error: $e'));
    }
  }
}
