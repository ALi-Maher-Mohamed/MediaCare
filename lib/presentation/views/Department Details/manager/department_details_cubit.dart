import 'package:bloc/bloc.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Department%20Details/data/repo/department_details_repo_impl.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_state.dart';

class DepartmentDetailsCubit extends Cubit<DepartmentDetailsState> {
  final DepartmentDetailsRepoImpl departmentDetailsRepoImpl;

  List<Hospital> hospitals = [];
  List<CareCenter> careCenters = [];
  List<Doctor> doctors = [];
  List<dynamic> filteredData = [];

  DepartmentDetailsCubit({required this.departmentDetailsRepoImpl})
      : super(DepartmentDetailsInitial());

  void getDepartmentDetails(String departmentID) async {
    emit(DepartmentDetailsLoading());

    try {
      final response =
          await departmentDetailsRepoImpl.getDepartmentDetails(departmentID);

      response.fold(
        (failure) {
          emit(DepartmentDetailsError(
              "Failed to fetch data: ${failure.errMessage}"));
        },
        (departmentDetailsModel) {
          hospitals = departmentDetailsModel.data.hospitals;
          careCenters = departmentDetailsModel.data.careCenters;
          doctors = departmentDetailsModel.data.doctors;

          emit(DepartmentDetailsLoaded(
            departmentDetails: departmentDetailsModel,
            filteredData: hospitals,
            selectedCategory: "المستشفيات",
          ));
        },
      );
    } catch (e) {
      emit(DepartmentDetailsError("Failed to fetch data: ${e.toString()}"));
    }
  }

  void filterDepartmentData(String category) {
    List<dynamic> filteredData;

    if (category == "المستشفيات") {
      filteredData = hospitals;
    } else if (category == "المراكز") {
      filteredData = careCenters;
    } else if (category == "الأطباء") {
      filteredData = doctors;
    } else {
      filteredData = [];
    }

    emit(DepartmentDetailsLoaded(
      departmentDetails: DepartmentDetailsModel(
        success: true,
        message: "Data loaded successfully",
        data: DepartmentDetails(
          department: Department(
            id: "",
            title: "",
            description: "",
          ),
          hospitalsCount: hospitals.length,
          careCentersCount: careCenters.length,
          doctorsCount: doctors.length,
          hospitals: hospitals,
          careCenters: careCenters,
          doctors: doctors,
          tips: [],
        ),
      ),
      filteredData: filteredData,
      selectedCategory: category,
    ));
  }
}
