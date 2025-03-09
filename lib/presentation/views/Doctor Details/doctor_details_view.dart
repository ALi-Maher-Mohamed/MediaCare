import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/repo/doctor_details_repo_impl.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_cubit.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_state.dart';

class DoctorDetailsView extends StatelessWidget {
  final String doctorID;
  const DoctorDetailsView({required this.doctorID, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Doctor Details',
          style: TextStyle(
            color: AppColors.primary2,
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: AppColors.primary,
                )),
              );
            }
            if (state is DoctorDetailsError) {
              return Center(
                child: Text('Error : ${state.message}'),
              );
            }
            if (state is DoctorDetailsLoaded) {
              return Column(
                children: [
                  Text('${state.DoctorDetails.data?.birthDate}'),
                ],
              );
            }
            return Center(child: Text('Unknown state')); // Fallback
          },
        ),
      ),
    );
  }
}
