import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Department/data/models/department_model.dart';
import 'package:media_care/presentation/views/Department/data/repo/department_repo.dart';
import 'department_state.dart';
class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentRepo departmentRepol;
  // List<DepartmentModel> departments = [];
  static DepartmentCubit get(context) => BlocProvider.of(context);
  DepartmentCubit({required this.departmentRepol}) : super(GetDepartmentInitial());
  bool isLoading = false;
  Future<void> getDepartmentData(dynamic page) async{
    isLoading = true;
    emit(GetDepartmentLoading());
    var response = await departmentRepol.fetchDepartments(page: 1);
    response.fold((failure) {
      isLoading = false;
      emit(GetDepartmentError(error: failure.errMessage));
    }, (data) {
      isLoading = false;
      // departments = data.data??;
      emit(GetDepartmentSuccess());
      return response;
    },);
  }

}