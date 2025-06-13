import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/laboratory_details/data/models/laboratory_details_model.dart';

abstract class LaboratoryState extends Equatable {
  const LaboratoryState();

  @override
  List<Object> get props => [];
}

class LaboratoryInitial extends LaboratoryState {}

class LaboratoryLoading extends LaboratoryState {}

class LaboratoryLoaded extends LaboratoryState {
  final LaboratoryResponse response;

  const LaboratoryLoaded(this.response);

  @override
  List<Object> get props => [response];
}

class LaboratoryError extends LaboratoryState {
  final String message;

  const LaboratoryError(this.message);

  @override
  List<Object> get props => [message];
}
