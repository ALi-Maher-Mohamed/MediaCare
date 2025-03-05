import '../../data/model/labs_model/data.dart';

abstract class LaboratoryState {}

class LaboratoryInitial extends LaboratoryState {}

class LaboratoryLoading extends LaboratoryState {}

class LaboratorySuccessState extends LaboratoryState {
  final List<LaboratoryModel> laboratories;
  final int currentPage;
  final bool hasMore;

  LaboratorySuccessState({
    required this.laboratories,
    required this.currentPage,
    required this.hasMore,
  });
}

class LaboratoryError extends LaboratoryState {
  final String message;
  LaboratoryError(this.message);
}
