import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Department%20Details/data/repo/department_details_repo_impl.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_cubit.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_state.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/FilterButton.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/care_center_card.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/doctor_card.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/hospital_card.dart';

class DepartmentDetailsScreen extends StatelessWidget {
  final String departmentID;
  final String title;

  const DepartmentDetailsScreen(
      {Key? key, required this.departmentID, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentDetailsCubit(
        departmentDetailsRepoImpl: DepartmentDetailsRepoImpl(
          ApiServiceFunctions(Dio()),
        ),
      )..getDepartmentDetails(departmentID),
      child: BlocBuilder<DepartmentDetailsCubit, DepartmentDetailsState>(
        builder: (context, state) {
          if (state is DepartmentDetailsLoading) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: CustomProgressIndicator(),
            );
          } else if (state is DepartmentDetailsLoaded) {
            String selectedCategory = state.selectedCategory;

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
                forceMaterialTransparency: true,
                iconTheme: Theme.of(context).iconTheme,
                title: Text(
                  '$title',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryButton(
                          title: "المستشفيات",
                          isSelected: selectedCategory == "المستشفيات",
                          onTap: () => context
                              .read<DepartmentDetailsCubit>()
                              .filterDepartmentData("المستشفيات"),
                        ),
                        CategoryButton(
                          title: "المراكز",
                          isSelected: selectedCategory == "المراكز",
                          onTap: () => context
                              .read<DepartmentDetailsCubit>()
                              .filterDepartmentData("المراكز"),
                        ),
                        CategoryButton(
                          title: "الأطباء",
                          isSelected: selectedCategory == "الأطباء",
                          onTap: () => context
                              .read<DepartmentDetailsCubit>()
                              .filterDepartmentData("الأطباء"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: state.filteredData.map((item) {
                        if (item.runtimeType == Hospital) {
                          return HospitalCard(hospital: item as Hospital);
                        } else if (item.runtimeType == CareCenter) {
                          return CareCenterCard(careCenter: item as CareCenter);
                        } else if (item.runtimeType == Doctor) {
                          return DoctorCard(doctor: item as Doctor);
                        } else {
                          return Container();
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DepartmentDetailsError) {
            return Center(
                child: Text('Error: ${state.message}',
                    style: Theme.of(context).textTheme.bodyMedium));
          }
          return Center(
              child: Text('Unknown state',
                  style: Theme.of(context).textTheme.bodyMedium));
        },
      ),
    );
  }
}
