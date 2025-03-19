import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription/data/models/Prescription_details_model.dart';

abstract class PrescriptionState extends Equatable {
  const PrescriptionState();

  @override
  List<Object?> get props => [];
}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionSuccess extends PrescriptionState {
  final PrescriptionData prescriptionData;

  const PrescriptionSuccess(this.prescriptionData);

  @override
  List<Object?> get props => [prescriptionData];
}

class PrescriptionFailure extends PrescriptionState {
  final String errorMessage;

  const PrescriptionFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
