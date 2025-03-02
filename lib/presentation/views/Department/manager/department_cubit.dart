import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Department/data/repo/department_repo_impl.dart';
import 'package:media_care/presentation/views/Department/manager/department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  final DepartmentRepoImpl departmentRepo;

  DepartmentCubit({required this.departmentRepo}) : super(DepartmentInitial());

  Future<void> fetchDepartments() async {
    emit(DepartmentLoading());
    try {
      final result = await departmentRepo.getDepartments();
      result.fold(
            (failure) => emit(DepartmentError(failure.errMessage)),
            (departmentResponse) => emit(DepartmentLoaded(departmentResponse)),
      );
    } catch (e) {
      emit(DepartmentError(e.toString()));
    }
  }
}