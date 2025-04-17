import 'package:equatable/equatable.dart';
import '../../data/models/delivery_service_model.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

class DeliveryInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliveryLoaded extends DeliveryState {
  final List<DeliveryServiceModel> services;

  const DeliveryLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class DeliveryError extends DeliveryState {
  final String message;

  const DeliveryError(this.message);

  @override
  List<Object> get props => [message];
}
