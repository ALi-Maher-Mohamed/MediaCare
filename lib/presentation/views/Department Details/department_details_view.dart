import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
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

  const DepartmentDetailsScreen({Key? key, required this.departmentID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => DepartmentDetailsCubit(
        departmentDetailsRepoImpl: DepartmentDetailsRepoImpl(
          ApiServiceFunctions(Dio()), // Pass token here
        ),
      )..getDepartmentDetails(departmentID),
      child: BlocBuilder<DepartmentDetailsCubit, DepartmentDetailsState>(
        builder: (context, state) {
          if (state is DepartmentDetailsLoading) {
            return Container(
              color: Colors.white,
              child: CustomProgressIndicator(),
            );
          } else if (state is DepartmentDetailsLoaded) {
            String selectedCategory = state.selectedCategory;

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                forceMaterialTransparency: true,
                iconTheme: IconThemeData(color: AppColors.primary),
                title: Text(
                  '$title',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary),
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
                          return HospitalCard(
                              hospital:
                                  item as Hospital); // قم بإنشاء HospitalCard
                        } else if (item.runtimeType == CareCenter) {
                          return CareCenterCard(
                              careCenter: item
                                  as CareCenter); // قم بإنشاء CareCenterCard
                        } else if (item.runtimeType == Doctor) {
                          return DoctorCard(doctor: item as Doctor);
                        } else {
                          return Container(); // Fallback في حالة وجود نوع غير معروف
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DepartmentDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Unknown state')); // Fallback
        },
      ),
    );
  }
}
