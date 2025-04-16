import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/repo/doctor_details_repo_impl.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_cubit.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_state.dart';
import 'package:media_care/presentation/views/Doctor%20Details/widgets/doctor_data.dart';
import 'package:media_care/presentation/views/Doctor%20Details/widgets/empty_space.dart';
import 'package:media_care/presentation/views/Doctor%20Details/widgets/more_info_doctor.dart';
import 'package:media_care/presentation/views/Doctor%20Details/widgets/reserve_appointment.dart';
import 'package:media_care/presentation/views/profile/data/repo/profile_repo_impl.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';

class DoctorDetailsView extends StatelessWidget {
  final String doctorID;
  const DoctorDetailsView({required this.doctorID, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'تفاصيل الدكتور ',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) => DoctorDetailsCubit(
          doctorDetailsRepoImplm: DoctorDetailsRepoImpl(
            ApiServiceFunctions(Dio()),
          ),
        )..getDoctorDetails(doctorID),
        child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
          builder: (context, state) {
            if (state is DoctorDetailsLoading) {
              return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: CustomProgressIndicator());
            }
            if (state is DoctorDetailsError) {
              return Center(
                child: Text(
                  'Error : ${state.message}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            if (state is DoctorDetailsLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    DoctorData(
                      fname: state.DoctorDetails.data?.fName,
                      lname: state.DoctorDetails.data?.lName,
                      image: state.DoctorDetails.data?.image,
                      phone: state.DoctorDetails.data?.phone,
                      title: state.DoctorDetails.data?.title,
                      facebookLink: state.DoctorDetails.data?.facebookLink,
                      specialization: state.DoctorDetails.data?.specializations,
                      whatsappLink: state.DoctorDetails.data?.whatsappLink,
                    ),
                    EmptySpace(),
                    MoreInfoDoctor(
                      moreInfoAboutDoctor:
                          state.DoctorDetails.data?.infoAboutDoctor,
                    ),
                    EmptySpace(),
                    BlocProvider(
                      create: (context) => ProfileCubit(
                        profileRepo:
                            ProfileRepoImpl(ApiServiceFunctions(Dio())),
                      )..fetchProfile(),
                      child: BookingDetailsScreen(
                        app_price: state.DoctorDetails.data?.appPrice,
                        homeOption: state.DoctorDetails.data?.homeOption,
                        clinicTitle:
                            state.DoctorDetails.data?.clinics?[0].title,
                        clinicAddress:
                            state.DoctorDetails.data?.clinics?[0].address,
                        appointment: state.DoctorDetails.data?.appointments,
                        doctorDetailsModel: state.DoctorDetails,
                        full_name: '${state.DoctorDetails.data?.fName}'
                            '${state.DoctorDetails.data?.lName}',
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                'Unknown state',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
        ),
      ),
    );
  }
}
