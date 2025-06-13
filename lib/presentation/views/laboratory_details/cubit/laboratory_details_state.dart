import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/laboratory_details/data/models/laboratory_details_model.dart';

abstract class LaboratoryDetailsState extends Equatable {
  const LaboratoryDetailsState();

  @override
  List<Object> get props => [];
}

class LaboratoryDetailsInitial extends LaboratoryDetailsState {}

class LaboratoryDetailsLoading extends LaboratoryDetailsState {}

class LaboratoryDetailsSuccess extends LaboratoryDetailsState {
  final LaboratoryDetailsResponse response;

  const LaboratoryDetailsSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class LaboratoryDetailsError extends LaboratoryDetailsState {
  final String message;

  const LaboratoryDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
