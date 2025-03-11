import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/Department%20Details/department_details_view.dart';
import 'package:media_care/presentation/views/Department/data/models/department_model.dart';
import 'package:media_care/presentation/views/Department/data/repo/department_repo_impl.dart';
import 'package:media_care/presentation/views/Department/widgets/department_item.dart';

import '../manager/department_cubit.dart';
import '../manager/department_state.dart';

class DepartmentsView extends StatefulWidget {
  const DepartmentsView({Key? key}) : super(key: key);

  @override
  State<DepartmentsView> createState() => _DepartmentsViewState();
}

class _DepartmentsViewState extends State<DepartmentsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentCubit(
          departmentRepo: DepartmentRepoImpl(ApiServiceFunctions(Dio())))
        ..fetchDepartments(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          iconTheme: IconThemeData(color: AppColors.primary),
          centerTitle: true,
          title: Text(
            'الأقـسـام',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.primary),
          ),
          titleTextStyle: TextStyle(
            color: Color(0xff0dcaf0),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: BlocConsumer<DepartmentCubit, DepartmentState>(
          listener: (context, state) {
            if (state is DepartmentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is DepartmentInitial) {
              return Center(child: Text('Initial state'));
            } else if (state is DepartmentLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            } else if (state is DepartmentLoaded) {
              final departments = state.departmentResponse.data.departments;
              return DepartmentGridBody(departments: departments);
            } else if (state is DepartmentError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class DepartmentGridBody extends StatelessWidget {
  const DepartmentGridBody({
    super.key,
    required this.departments,
  });

  final List<Department> departments;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
          crossAxisCount: 2),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final department = departments[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepartmentDetailsScreen(
                  departmentID: department.id, // Pass departmentID
                ),
                settings: RouteSettings(
                  arguments: department.title, // Pass title as an argument
                ),
              ),
            );
          },
          child: DepartmentItem(
            title: department.title,
            iconUrl: department.icon,
          ),
        );
      },
    );
  }
}
