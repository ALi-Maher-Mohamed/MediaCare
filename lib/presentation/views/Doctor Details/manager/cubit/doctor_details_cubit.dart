import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/repo/doctor_details_repo_impl.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final DoctorDetailsRepoImpl doctorDetailsRepoImplm;

  DoctorDetailsCubit({required this.doctorDetailsRepoImplm})
      : super(DoctorDetailsInitial());

  void getDoctorDetails(String DoctorID) async {
    emit(DoctorDetailsLoading());

    try {
      final response = await doctorDetailsRepoImplm.getDoctorDetails(DoctorID);

      response.fold(
        (failure) {
          emit(DoctorDetailsError(
              "Failed to fetch data: ${failure.errMessage}"));
        },
        (DoctorDetailsModel) {
          emit(DoctorDetailsLoaded(
            DoctorDetails: DoctorDetailsModel,
          ));
        },
      );
    } catch (e) {
      emit(DoctorDetailsError("Failed to fetch data: ${e.toString()}"));
    }
  }
}
