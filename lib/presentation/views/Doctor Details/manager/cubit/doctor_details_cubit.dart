import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/repo/doctor_details_repo_impl.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final DoctorDetailsRepoImpl doctorDetailsRepoImplm;

  DoctorDetailsCubit({required this.doctorDetailsRepoImplm})
      : super(DoctorDetailsInitial());
  static DoctorDetailsCubit of(BuildContext context) =>
      BlocProvider.of<DoctorDetailsCubit>(context);

  String? app_price;
  int? homeOption;
  String? clinicTitle;
  String? clinicAddress;
  List<Appointment>? appointment;
  DoctorDetailsModel? doctorDetailsModel;
  PageController pageController = PageController();

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

  int currentPage = 0;
  void nextPage() {
    final totalDates =
        doctorDetailsModel?.data?.appointmentsGroupedByDate?.length ?? 0;

    if (currentPage < totalDates - 1) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
