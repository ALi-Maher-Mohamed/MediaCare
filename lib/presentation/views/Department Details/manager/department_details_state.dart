import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';

abstract class DepartmentDetailsState extends Equatable {
  const DepartmentDetailsState();

  @override
  List<Object> get props => [];
}

class DepartmentDetailsInitial extends DepartmentDetailsState {}

class DepartmentDetailsLoading extends DepartmentDetailsState {}

class DepartmentDetailsLoaded extends DepartmentDetailsState {
  final DepartmentDetailsModel departmentDetailsModels;

  const DepartmentDetailsLoaded(this.departmentDetailsModels);

  @override
  List<Object> get props => [departmentDetailsModels];
}

class DepartmentError extends DepartmentDetailsState {
  final String message;

  const DepartmentError(this.message);

  @override
  List<Object> get props => [message];
}
