import 'package:bloc/bloc.dart';
import 'package:media_care/presentation/views/Department%20Details/data/repo/department_details_repo_impl.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_state.dart';

class DepartmentDetailsCubit extends Cubit<DepartmentDetailsState> {
  final DepartmentDetailsRepoImpl departmentDetailsRepoImpl;

  DepartmentDetailsCubit({required this.departmentDetailsRepoImpl})
      : super(DepartmentDetailsInitial());

  Future<void> fetchDepartments(String? id) async {
    emit(DepartmentDetailsLoading());
    try {
      final result = await departmentDetailsRepoImpl.getDepartmentDetails(id);
      result.fold(
        (failure) => emit(DepartmentError(failure.errMessage)),
        (departmentResponse) =>
            emit(DepartmentDetailsLoaded(departmentResponse)),
      );
    } catch (e) {
      emit(DepartmentError(e.toString()));
    }
  }
}
