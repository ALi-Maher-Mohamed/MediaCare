import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/data.dart';

abstract class LaboratoryState {}

class LaboratoryInitialState extends LaboratoryState {}

class LaboratoryLoadingState extends LaboratoryState {}

class LaboratorySuccessState extends LaboratoryState {
  final List<LaboratoryModel> laboratories;
  LaboratorySuccessState(this.laboratories);
}

class LaboratoryFailure extends LaboratoryState {
  final String error;
  LaboratoryFailure(this.error);
}
