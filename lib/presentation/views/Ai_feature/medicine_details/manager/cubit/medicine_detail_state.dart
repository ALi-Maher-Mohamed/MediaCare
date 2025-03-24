import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';

abstract class MedicineDetailState extends Equatable {
  const MedicineDetailState();

  @override
  List<Object?> get props => [];
}

class MedicineDetailInitial extends MedicineDetailState {}

class MedicineDetailLoading extends MedicineDetailState {}

class MedicineDetailSuccess extends MedicineDetailState {
  final MedicineDetail medicineDetail;

  const MedicineDetailSuccess(this.medicineDetail);

  @override
  List<Object?> get props => [medicineDetail];
}

class MedicineDetailFailure extends MedicineDetailState {
  final String errorMessage;

  const MedicineDetailFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
