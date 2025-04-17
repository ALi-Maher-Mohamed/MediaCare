import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/delivery_options/manager/cubit/delivery_cubit_state.dart';
import '../../data/repos/delivery_service_repo.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  final DeliveryServiceRepo deliveryServiceRepo;

  DeliveryCubit(this.deliveryServiceRepo) : super(DeliveryInitial());

  Future<void> fetchDeliveryServices() async {
    emit(DeliveryLoading());
    final result = await deliveryServiceRepo.fetchDeliveryServices();
    result.fold(
      (failure) => emit(DeliveryError(failure.errMessage)),
      (services) => emit(DeliveryLoaded(services)),
    );
  }
}
