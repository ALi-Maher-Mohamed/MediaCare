import 'package:equatable/equatable.dart';
import 'package:media_care/presentation/views/Department/data/models/department_model.dart';

abstract class DepartmentState extends Equatable {
  const DepartmentState();

  @override
  List<Object> get props => [];
}

class DepartmentInitial extends DepartmentState {}

class DepartmentLoading extends DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  final DepartmentResponse departmentResponse;

  const DepartmentLoaded(this.departmentResponse);

  @override
  List<Object> get props => [departmentResponse];
}

class DepartmentError extends DepartmentState {
  final String message;

  const DepartmentError(this.message);

  @override
  List<Object> get props => [message];
}