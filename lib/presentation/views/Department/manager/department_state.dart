abstract class DepartmentState {}

class GetDepartmentInitial extends DepartmentState {}

class GetDepartmentLoading extends DepartmentState {}

class GetDepartmentSuccess extends DepartmentState {
  // final List<> departments;
  // GetDepartmentSuccess(this.departments);
}

class GetDepartmentError extends DepartmentState {
  final String error;
  GetDepartmentError({required this.error});
}
