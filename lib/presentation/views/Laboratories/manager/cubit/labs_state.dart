import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/data.dart';

abstract class LaboratoryState {}

class LaboratoryInitial extends LaboratoryState {}

class LaboratoryLoading extends LaboratoryState {}

class LaboratoryLoaded extends LaboratoryState {
  final List<LaboratoryModel> laboratories;
  LaboratoryLoaded(this.laboratories);
}

class LaboratoryError extends LaboratoryState {
  final String error;
  LaboratoryError(this.error);
}
