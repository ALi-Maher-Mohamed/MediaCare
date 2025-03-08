import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/Department%20Details/data/repo/department_details_repo_impl.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_cubit.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_state.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/FilterButton.dart';

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
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: AppColors.primary,
              )),
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
                        return ListTile(
                          title: Text(item
                              .title), // Ensure `item` has a `title` property
                        );
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
