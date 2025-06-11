import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/data.dart';

abstract class LaboratoryState {}

class LaboratoryInitial extends LaboratoryState {}

class LaboratoryLoadingState extends LaboratoryState {}

class LaboratorySuccessState extends LaboratoryState {
  final List<LaboratoryModel>
      laboratories; // القائمة المعروضة (مفلترة أو كاملة)
  final List<LaboratoryModel> allLaboratories; // القائمة الأصلية

  LaboratorySuccessState(this.laboratories, this.allLaboratories);
}

class LaboratoryErrorState extends LaboratoryState {
  final String errorMessage;
  LaboratoryErrorState(this.errorMessage);
}
