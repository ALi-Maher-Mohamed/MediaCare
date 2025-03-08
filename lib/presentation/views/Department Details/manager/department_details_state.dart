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
  final DepartmentDetailsModel departmentDetails;
  final List<dynamic> filteredData;
  final String selectedCategory;

  DepartmentDetailsLoaded({
    required this.departmentDetails,
    required this.filteredData,
    required this.selectedCategory,
  });

  @override
  List<Object> get props => [departmentDetails, filteredData, selectedCategory];
}

class DepartmentDetailsError extends DepartmentDetailsState {
  final String message;

  const DepartmentDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
