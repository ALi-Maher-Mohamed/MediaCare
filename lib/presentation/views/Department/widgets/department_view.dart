import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Department/data/repo/department_repo_impl.dart';
import 'package:media_care/presentation/views/Department/widgets/department_grid_body.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          forceMaterialTransparency: true,
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
          title: Text(
            'الأقـسـام',
            style: Theme.of(context).textTheme.titleLarge,
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
              return Center(
                  child: Text('Initial state',
                      style: Theme.of(context).textTheme.bodyMedium));
            } else if (state is DepartmentLoading) {
              return CustomProgressIndicator();
            } else if (state is DepartmentLoaded) {
              final departments = state.departmentResponse.data.departments;
              return DepartmentGridBody(departments: departments);
            } else if (state is DepartmentError) {
              return Center(
                  child: Text('Error: ${state.message}',
                      style: Theme.of(context).textTheme.bodyMedium));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
